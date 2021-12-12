package kube

import (
	"strings"
	"regexp"
	"encoding/json"
	"tool/file"
	"tool/exec"
)

command: godeps: {
	task: {
		readDefsGo: file.Read & {
			filename: "kube_defs.go"
			contents: string
		}
		let packages = [ for field in strings.Fields(task.readDefsGo.contents) if strings.Contains(field, "\"") {strings.Trim(field, "\"")}]
		getGo: exec.Run & {
			cmd: ["sh", "-c", strings.Join([ for package in packages {
				strings.Join([
					"echo -n \(package)..",
					"go get \(package)",
					"echo -n .",
					"cue get go \(package)",
					"echo done."],
				"&&")
			}], "\n")]
		}
		deleteReflect: exec.Run & {
			$after: [getGo]
			cmd: "sed -i /reflect/d ./cue.mod/gen/github.com/go-openapi/strfmt/format_go_gen.cue"
		}
	}
}

command: depversions: task: {
	readGoMod: file.Read & {
		filename: "go.mod"
		contents: string
	}
	let re = #"^\s+([-\w./]+)\s+([-\w.]+)$"#
	let packages = {
		for line in strings.Split(readGoMod.contents, "\n") if line =~ re {
			let match = regexp.FindSubmatch(re, line)
			"\(match[1])": match[2]
		}
	}
	writeVersionsCue: file.Create & {
		filename: "util/go-mod-versions.cue"
		contents: """
            package util

            goModVersions: \(json.Indent(json.Marshal(packages), "", "\t"))
            """
	}
	cueFmt: exec.Run & {
		$after: [writeVersionsCue]
		cmd: "cue fmt ./util/go-mod-versions.cue"
	}
}

command: jsonnetdeps: task: {
	"kubernetes-mixin": exec.Run & {
		dir: "cue.mod/pkg/github.com/kubernetes-monitoring/kubernetes-mixin"
		cmd: ["sh", "-c", """
			#go install github.com/google/go-jsonnet/cmd/jsonnet@latest
			#go install github.com/jsonnet-bundler/jsonnet-bundler/cmd/jb@latest

			git pull

			jb install

			make prometheus_alerts.yaml
			make prometheus_rules.yaml
			make dashboards_out

			cue import -f -p dashboards --with-context -l 'path.Base(filename)' dashboards_out/*
			cue import -f -p mixin -l '"alerts"' prometheus_alerts.yaml
			cue import -f -p mixin -l '"rules"' prometheus_rules.yaml

			mkdir -p ../../../../gen/github.com/kubernetes-monitoring/kubernetes-mixin/dashboards

			mv *.cue ../../../../gen/github.com/kubernetes-monitoring/kubernetes-mixin/
			mv dashboards_out/*.cue ../../../../gen/github.com/kubernetes-monitoring/kubernetes-mixin/dashboards

			git clean -fd
			"""]
	}
}

command: jsonnetdeps: task: {
	"kube-prometheus": exec.Run & {
		dir: "cue.mod/pkg/github.com/prometheus-operator/kube-prometheus"
		cmd: ["sh", "-c", """
			#go install github.com/google/go-jsonnet/cmd/jsonnet@latest
			#go install github.com/jsonnet-bundler/jsonnet-bundler/cmd/jb@latest

			git pull

			jb install

			jsonnet -J vendor -m manifests -c ../export.jsonnet

			cue import -p manifests -l kind -l metadata.name -f ./manifests/*.json

			mkdir -p ../../../../gen/github.com/prometheus-operator/kube-prometheus/manifests
			mv manifests/*.cue ../../../../gen/github.com/prometheus-operator/kube-prometheus/manifests

			git clean -fd
			"""]
	}
}
