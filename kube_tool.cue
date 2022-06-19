package kube

import (
	"list"
	"encoding/yaml"
	"encoding/json"
	"text/tabwriter"
	"tool/cli"
	"tool/file"
	"tool/exec"
)

context: string

let earlyKinds = ["Namespace", "CustomResourceDefinition"]
let earlyResources = [ for kind, rs in k for r in rs if list.Contains(earlyKinds, kind) {r}]
let resources = [ for kind, rs in k for r in rs if !list.Contains(earlyKinds, kind) {r}]

// List defined Kubernetes resources
command: ls: {
	print: cli.Print & {
		text: tabwriter.Write([
			for r in earlyResources {
				"\(r.kind) \t\(*r.metadata.namespace | "") \t\(r.metadata.name)"
			},
		]) + "\n" + tabwriter.Write([
			for r in resources {
				"\(r.kind) \t\(*r.metadata.namespace | "") \t\(r.metadata.name)"
			},
		])
	}
}

// Apply Kubernetes resources. Always starts with Namespace and CustomResourceDefinition.
command: apply: {
	if len(earlyResources) > 0 {
		applyEarly: exec.Run & {
			cmd: ["kubectl", "--context", context, "apply", "-f-"]
			stdin: json.MarshalStream(earlyResources)
		}
	}
	if len(resources) > 0 {
		apply: exec.Run & {
			$after: [apply.applyEarly]
			cmd: ["kubectl", "--context", context, "apply", "-f-"]
			stdin: json.MarshalStream(resources)
		}
	}
}

// Diff Kubernetes resources with the current cluster state
command: diff: {
	diff: exec.Run & {
		cmd: ["kubectl", "--context", context, "diff", "-f-"]
		stdin: json.MarshalStream(resources)
	}
}

// Create SealedSecret resources for any existing Secret resources. The existing secret resource has to be removed manually!
command: seal: {
	scope: *"strict" | "cluster-wide" @tag(scope)

	secrets: {
		for key, value in k.Secret {
			(key): exec.Run & {
				cmd: ["kubeseal", "--context", context, "--scope", scope]
				stdin:   json.Marshal(value)
				stdout:  string
				content: json.Unmarshal(stdout)
			}
		}
	}

	write: #WriteGeneratedCue & {
		filename: "sealed-secrets.cue"
		content: {
			k: SealedSecret: {
				for key, value in secrets {
					(key): value.content
				}
			}
		}
	}
}

// Dump a yaml stream of Kubernetes resources
command: "dump-yaml": {
	print: cli.Print & {
		text: yaml.MarshalStream(earlyResources + resources)
	}
}

// Import all existing yaml files into their cue representation
command: "import-yaml": {
	import: exec.Run & {
		cmd: ["cue", "import", "-p", "kube", "-l", "\"k\"", "-l", "kind", "-l", "metadata.name", "yaml:", "-"]
	}
}
// Import all existing yaml files into their cue representation
command: "import-all-yaml": {
	import: exec.Run & {
		cmd: "cue import -p kube -l '\"k\"' -l 'kind' -l metadata.name -f ./**/*.yaml"
	}
}

// Bootstrap the initial flux controllers to enable Kustomization and HelmRelease resources.
command: "flux-bootstrap": {
	apply: exec.Run & {
		cmd: "kubectl apply -k https://github.com/fluxcd/flux2/manifests/install"
	}
}

#WriteGeneratedCue: {
	filename: string
	package:  string | *"kube"
	content:  _

	filenameGlob: file.Glob & {
		glob: filename
		files: [...string]
	}
	existing: _ | *[]
	if len(filenameGlob.files) > 0 {
		existing: ["cue:", filename]
	}
	eval: exec.Run & {
		cmd: ["cue",
			"eval",
			"--all",
			"--show-attributes",
			"json:", "-",
		] + existing
		stdin:  json.Marshal(content)
		stdout: string
	}

	fmt: exec.Run & {
		cmd: ["cue", "fmt", "--simplify", "-"]
		stdin:  eval.stdout
		stdout: string
	}

	write: file.Create & {
		"filename": filename
		contents:   """
		package \(package)

		\(fmt.stdout)
		"""
	}
}
