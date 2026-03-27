package kube

import (
	"list"
	"encoding/yaml"
	"encoding/json"
	"text/tabwriter"
	"tool/cli"
	"tool/exec"
	"tool/os"
)

_kindfilter: string | *".*" @tag(kind)
_namefilter: string | *".*" @tag(name)

let earlyKinds = ["Namespace", "CustomResourceDefinition"]
let res = [for kind, rs in k for r in rs if r.kind =~ _kindfilter && r.metadata.name =~ _namefilter {r}]
let earlyResources = [for r in res if list.Contains(earlyKinds, r.kind) {r}]
let resources = [for r in res if !list.Contains(earlyKinds, r.kind) {r}]

// List defined Kubernetes resources
command: ls: cli.Print & {
	text: tabwriter.Write([
		"Kind\tNamesspace\tName",
		for r in earlyResources {
			"\(r.kind) \t\(*r.metadata.namespace | "") \t\(r.metadata.name)"
		},
		for r in resources {
			"\(r.kind) \t\(*r.metadata.namespace | "") \t\(r.metadata.name)"
		},
	])
}

// Apply Kubernetes resources. Always starts with Namespace and CustomResourceDefinition.
command: apply: {
	if len(earlyResources) > 0 {
		applyEarly: exec.Run & {
			cmd: ["kubectl", "apply", "-f-"]
			stdin: yaml.MarshalStream(earlyResources)
		}
	}
	if len(resources) > 0 {
		apply: exec.Run & {
			$after: [apply.applyEarly]
			cmd: ["kubectl", "apply", "-f-"]
			stdin: yaml.MarshalStream(resources)
		}
	}
}

osenv: os.Environ
// Diff Kubernetes resources with the current cluster state
command: diff: exec.Run & {
	cmd: ["kubectl", "diff", "-f-"]
	env: {for key, value in osenv if key != "$id" {(key): value}}
	stdin: json.MarshalStream(resources)
}

// Dump a yaml stream of Kubernetes resources
command: "dump-yaml": cli.Print & {
	text: yaml.MarshalStream(list.Concat([earlyResources, resources]))
}

// Import all yaml from stdin
command: "import-yaml": exec.Run & {
	cmd: ["cue", "import", "-R", "-p", "kube", "-l", "\"k\"", "-l", "kind", "-l", "metadata.name", "yaml:", "-", "-o", "-"]
}

// Import all existing yaml files into their cue representation
command: "import-all-yaml": exec.Run & {
	cmd: "cue import -p kube -l '\"k\"' -l 'kind' -l metadata.name -f ./**/*.yaml"
}

let sops = {
	$action: "encrypt" | "decrypt"

	out: [
		"find", "-name", "*.enc.cue",
		if $action == "encrypt" {"!"},
		"-exec", "grep", "-q", #""data": "ENC"#, "{}", ";",
		"-print",
		"-exec", "sops", $action, "--in-place", "{}", ";",
	]
}

command: "seal": exec.Run & {
	cmd: (sops & {$action: "encrypt"}).out
}

command: "unseal": exec.Run & {
	cmd: (sops & {$action: "decrypt"}).out
}
