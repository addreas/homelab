package kube

import (
	"strings"
	"tool/file"
	"tool/exec"
)

command: dependencies: {
	task: {
		readDefsGo: file.Read & {
			filename: "kube_defs.go"
			contents: string
		}
		let packages = [ for field in strings.Fields(task.readDefsGo.contents) if strings.Contains(field, "\"") { strings.Trim(field, "\"") }]
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
