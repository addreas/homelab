package kube

import (
	"encoding/json"
	"regexp"
	"strings"

	"tool/exec"
	"tool/os"
)

_versions: [string]: {datasource: string, depName: string, currentValue: string | null}

let podSpecs = [
	for name, r in k.Deployment {r.spec.template.spec}
	for name, r in k.StatefulSet {r.spec.template.spec}
	for name, r in k.DaemonSet {r.spec.template.spec}
	for name, r in k.Job {r.spec.template.spec}
	for name, r in k.CronJob {r.spec.jobTemplate.spec.template.spec}
	for name, r in k.Pod {r.spec}
]

let imageDep = {
	image: string
	out: [string]: _

	// [registry/repo][:tag][@digest]
	let match = regexp.FindSubmatch("^([^@]+?)(?::([^@/:]+))?(?:@(sha256:[0-9a-f]+))?$", image)

	let dep = {
		datasource:   "docker"
		depName:      match[1]
		currentValue: string | null
		if match[3] != "" {currentValue: match[3]}
		if match[3] == "" && match[2] != "" {currentValue: match[2]}
		if match[3] == "" && match[2] == "" {currentValue: null}
	}

	_key: *"docker\t\(dep.depName)\t\(dep.currentValue)" | "docker\t\(dep.depName)"
	out: (_key): dep
}

_versions: {
	for spec in podSpecs {
		for c in spec.containers {(imageDep & {image: c.image}).out}
		if spec.initContainers != _|_ {
			for c in spec.initContainers {(imageDep & {image: c.image}).out}
		}
	}
}

_versions: {for r in k.GitRepository if r.spec.ref != _|_ && r.spec.ref.tag != _|_ {
	"git\t\(r.spec.url)\t\(r.spec.ref.tag)": {
		datasource:   "git-tags"
		depName:      r.spec.url
		currentValue: r.spec.ref.tag
	}
}}

_versions: {for r in k.HelmRelease if r.spec.chart.spec.version != _|_ {
	"helm\t\(r.spec.chart.spec.chart)\t\(r.spec.chart.spec.version)": {
		datasource:   "helm"
		depName:      r.spec.chart.spec.chart
		currentValue: r.spec.chart.spec.version
	}
}}

osenv: os.Environ

command: lintrenovate: {
	// renovate's extract log: JSON records on stdout
	renovate: exec.Run & {
		cmd: ["renovate", "--platform", "local", "--dry-run=extract"]
		env: {
			for key, value in osenv
			if key != "$id" && key != "LOG_LEVEL" && key != "LOG_FORMAT" {(key): value}
			LOG_LEVEL:  "info"
			LOG_FORMAT: "json"
		}
		stdout: string
	}

	// renovate's regex-manager deps, as-is. go.mod and Dockerfile deps are
	// managed by renovate too, but not rendered by this repo's k.
	_extracted: [
		for r in json.UnmarshalStream(renovate.stdout)
		if r.msg == "Extracted dependencies"
		for f in r.packageFiles.regex
		for d in f.deps {d}]

	_violations: {
		if len(_versions) == 0 {
			"no rendered versions — run: cue cmd lintrenovate ./resources/...": true
		}

		for _, dep in _versions {
			if dep.datasource == "git-tags" {
				if len([for d in _extracted if (d & dep) != _|_ {d}]) == 0 {"untracked git repo \(dep.depName)": true}
			}
			if dep.datasource == "helm" {
				if len([for d in _extracted if (d & dep) != _|_ {d}]) == 0 {"untracked helm chart \(dep.depName)": true}
			}
			if dep.datasource == "docker" {
				if dep.currentValue == null {
					"untagged image \(dep.depName)": true
				}
				if dep.currentValue != null
				if !strings.HasPrefix(dep.currentValue, "sha256:")
				if len([for d in _extracted
					if d.datasource == "docker"
					if d.depName == dep.depName
					if strings.HasPrefix(dep.currentValue, d.currentValue) {d}]) == 0 {
					"untracked image \(dep.depName):\(dep.currentValue)": true
				}
			}
		}
	}

	// "" unifies with "" and passes; any violation conflicts and the joined
	// message is the error
	status: ""
	status: strings.Join([for m, _ in _violations {m}], "; ")
}
