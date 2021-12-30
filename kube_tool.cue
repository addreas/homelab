package kube

import (
	"encoding/yaml"
	"encoding/json"
	"text/tabwriter"
	"tool/cli"
	"tool/file"
	"tool/exec"
)

context: string

let resources = [ for resourceType in k for resource in resourceType {resource}]

command: ls: task: print: cli.Print & {
	text: tabwriter.Write([
		for r in resources {
			"\(r.kind) \t\(*r.metadata.namespace | "") \t\(r.metadata.name)"
		},
	])
}

command: dump: task: print: cli.Print & {
	text: yaml.MarshalStream(resources)
}

command: apply: task: apply: exec.Run & {
	cmd: ["kubectl", "--context", context, "apply", "-f-"]
	stdin: json.MarshalStream(resources)
}

command: diff: task: diff: exec.Run & {
	cmd: ["kubectl", "--context", context, "diff", "-f-"]
	stdin: json.MarshalStream(resources)
}

command: seal: {
	scope: *"strict" | "cluster-wide" @tag(scope)
	task: stdinSecret: file.Read & {
		filename: "/dev/stdin"
		contents: string
	}
	let res = task.stdinSecret.contents
	task: print: cli.Print & {
		text: res
	}
	task: seal: exec.Run & {
		cmd: ["kubeseal", "--context", context, "--scope", scope]
		stdin: res
	}
}

command: kubeImport: {
	task: import: exec.Run & {
		cmd: "cue import -p kube -l '\"k\"' -l 'kind' -l metadata.name -f ./**/*.yaml"
	}
}

command: fluxBootstrap: {
	task: apply: exec.Run & {
		cmd: "kubectl apply -k https://github.com/fluxcd/flux2/manifests/install"
	}
}
