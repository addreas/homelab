package kube

import "tool/exec"

command: "kratos-config-schema": task: {
	curl: exec.Run & {
		cmd: [
			"curl",
			"-sSLo",
			"kratos-config-schema.json",
			"https://raw.githubusercontent.com/ory/kratos/master/embedx/config.schema.json",
		]
	}
	import: exec.Run & {
		$after: [curl]
		cmd: [
			"cue",
			"import",
			"-p", "kube",
			"-l", "#KratosConfigSchema:",
			"jsonschema",
			"kratos-config-schema.json",
		]
	}
	rm: exec.Run & {
		$after: [import]
		cmd: ["rm", "kratos-config-schema.json"]
	}
}

command: "hydra-config-schema": task: {
	curl: exec.Run & {
		cmd: [
			"curl",
			"-sSLo",
			"hydra-config-schema.json",
			"https://raw.githubusercontent.com/ory/hydra/master/spec/config.json",
		]
	}
	import: exec.Run & {
		$after: [curl]
		cmd: [
			"cue",
			"import",
			"-p", "kube",
			"-l", "#HydraConfigSchema:",
			"jsonschema",
			"hydra-config-schema.json",
		]
	}
	rm: exec.Run & {
		$after: [import]
		cmd: ["rm", "hydra-config-schema.json"]
	}
}
