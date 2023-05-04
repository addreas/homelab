package kube

import (
	"strings"
	"regexp"
	"tool/file"
	"tool/exec"
)

// runs `go get` and `cue get go` for all packages imported in kube_defs.go
command: "update-gomod-defs": {
	readDefsGo: file.Read & {
		filename: "kube_defs.go"
		contents: string
	}

	let matches = regexp.FindAllSubmatch(#"\s*_\s*"(.+)"(\s*//\s*(.*))?\n"#, readDefsGo.contents, -1)

	let commands = [
		for match in matches {
			let package = match[1]
			let args = match[3]
			strings.Join([
				"echo -n \(package)..",
				"go get \(package)",
				"echo -n .",
				"cue get go \(package) \(args)",
				"echo done."],
			" && ")
		},
	]

	run: exec.Run & {
		cmd: ["sh", "-c", strings.Join(commands, "\n")]
	}
}

// Extracts jsonnet config and generates cue definitions.
command: "update-jsonnet-defs": "kube-prometheus": exec.Run & {
	dir: "cue.mod/pkg/github.com/prometheus-operator/kube-prometheus"
	cmd: ["sh", "-c", """
		echo $PWD
		#go install github.com/google/go-jsonnet/cmd/jsonnet@latest
		#go install github.com/jsonnet-bundler/jsonnet-bundler/cmd/jb@latest
		set -e
		git clean -fd
		git restore .

		git checkout main

		git pull

		jb install

		jsonnet -J vendor -m manifests -c ../export.jsonnet

		cue import -p manifests -f ./manifests/*.json

		mkdir -p ../../../../gen/github.com/prometheus-operator/kube-prometheus/manifests
		mv manifests/*.cue ../../../../gen/github.com/prometheus-operator/kube-prometheus/manifests

		git clean -fd
		git restore .
		"""]
}
