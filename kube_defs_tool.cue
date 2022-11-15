package kube

import (
	"strings"
	"tool/file"
	"tool/exec"
)

// runs `go get` and `cue get go` for all packages imported in kube_defs.go
command: "update-gomod-defs": {
	readDefsGo: file.Read & {
		filename: "kube_defs.go"
		contents: string
	}
	let packages = [ for field in strings.Fields(readDefsGo.contents) if strings.Contains(field, "\"") {strings.Trim(field, "\"")}]
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
	deleteNetUrl: exec.Run & {
		$after: [getGo]
		cmd: "sed -i /url/d ./cue.mod/gen/github.com/VictoriaMetrics/operator/api/v1beta1/vmrule_types_go_gen.cue"
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
		git pull origin main --rebase

		jb install

		jsonnet -J vendor -m manifests -c ../export.jsonnet

		cue import -p manifests -f ./manifests/*.json

		mkdir -p ../../../../gen/github.com/prometheus-operator/kube-prometheus/manifests
		mv manifests/*.cue ../../../../gen/github.com/prometheus-operator/kube-prometheus/manifests

		git clean -fd
		git restore .
		"""]
}
