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

command: ls: {
	task: print: cli.Print & {
		text: tabwriter.Write([
			for r in resources {
				"\(r.kind) \t\(*r.metadata.namespace | "") \t\(r.metadata.name)"
			},
		])
	}
}

command: dump: {
	task: print: cli.Print & {
		text: yaml.MarshalStream(resources)
	}
}

command: apply: {
	task: apply: exec.Run & {
		cmd: ["kubectl", "--context", context, "apply", "-f-"]
		stdin: json.MarshalStream(resources)
	}
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

command: yamls: {
	let outdir = "yamls"
	task: {
		mkdirs: exec.Run & {
			cmd:    ["mkdir", "-p"] + [ for r in resources {"\(outdir)/\(*(r.metadata.namespace+"/") | "")\(r.kind)/"}]
			stdout: string
		}
		for r in resources {
			let name = "\(outdir)/\(*(r.metadata.namespace+"/") | "")\(r.kind)/\(r.metadata.name).yaml"
			"write \(name)": file.Create & {
				filename: name + mkdirs.stdout
				contents: yaml.Marshal(r)
			}
			"print \(name)": cli.Print & {
				text: name + mkdirs.stdout
			}
		}
	}
}
