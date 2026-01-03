package kube

import (
	"list"
	"strings"
	"encoding/yaml"
	"encoding/json"
	"text/tabwriter"
	"tool/cli"
	"tool/file"
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
			cmd: ["kubectl", "replace", "-f-"]
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

// Create SealedSecret resources for any existing Secret resources. The existing secret resource has to be removed manually!
command: seal: {
	scope: *"strict" | "cluster-wide" @tag(scope)

	let unsealed = [for key, value in k.Secret if k.SealedSecret[key] == _|_ {key}]

	secrets: {
		for key in unsealed {
			(key): exec.Run & {
				cmd: ["kubeseal", "--scope", scope]
				stdin:  yaml.Marshal(k.Secret[key])
				stdout: string
				content: yaml.Unmarshal(strings.Join([for l in strings.Split(stdout, "\n") if l !~ "null" {l}], "\n"))
			}
		}
	}

	write: #WriteGeneratedCue & {
		filename: "sealed-secrets.cue"
		content: "k": SealedSecret: {
			for key, value in k.SealedSecret if !list.Contains(unsealed, key) {
				(key): value
			}
			for key, value in secrets {
				(key): value.content
			}
		}
	}
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

// Bootstrap the initial flux controllers to enable Kustomization and HelmRelease resources.
command: "flux-bootstrap": exec.Run & {
	cmd: "kubectl apply -k https://github.com/fluxcd/flux2/manifests/install"
}

#WriteGeneratedCue: {
	filename: string
	package:  string | *"kube"
	content:  _

	filenameGlob: file.Glob & {
		glob: filename
		files: [...string]
	}
	let hasExisting = len(filenameGlob.files) > 0

	eval: exec.Run & {
		stdin:  json.Marshal(content)
		stdout: string
	}
	if !hasExisting {
		eval: cmd: ["cue",
			"eval",
			"--all",
			"--show-attributes",
			"json:", "-"]
	}

	if hasExisting {
		makeOptionals: exec.Run & {
			$after: [content]
			cmd: ["sed", "-i", #"s/ "/_ \| \*"/"#, filename]
			success: true
		}
		eval: {
			$after: [hasExisting, makeOptionals]
			cmd: ["cue",
				"eval",
				"--all",
				"--show-attributes",
				"json:", "-",
				"cue:", filename,
			]
		}
	}

	write: file.Create & {
		"filename": filename
		contents:   """
		package \(package)

		\(eval.stdout)
		"""
	}

	// trim: exec.Run & {
	// 	$after: [write.contents]
	// 	cmd: ["cue", "trim", "--simplify"]
	// }
}
