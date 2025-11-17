package kube

import (
	"tool/exec"
)

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
