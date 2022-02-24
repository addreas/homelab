package kube

import (
	"tool/exec"
	"tool/file"
)

command: "kratos-config-schema": task: {
	curl: exec.Run & {
		cmd: [
			"curl",
			"-sSL",
			"https://raw.githubusercontent.com/ory/kratos/master/embedx/config.schema.json",
		]
		stdout: string
	}
	jq: exec.Run & {
		cmd: [
			"jq",
			"""
			del(.definitions.selfServiceWebHook.properties.config.properties.additionalProperties)
			| del(.properties.courier.properties.sms.properties.request_config.properties.additionalProperties)
			| del(.required[] | select(. == "dsn"))
			""",
		],
		stdin: curl.stdout
		stdout: string
	}
	write: file.Create & {
		filename: "kratos-config-schema.json"
		contents: jq.stdout
	}
	import: exec.Run & {
		$after: [write]
		cmd: [
			"cue",
			"import",
			"-p", "kube",
			"-l", "#KratosConfigSchema:",
			"-f",
			"jsonschema",
			"kratos-config-schema.json",
		]
		stdin: jq.stdout
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
			"-f",
			"jsonschema",
			"hydra-config-schema.json",
		]
	}
	rm: exec.Run & {
		$after: [import]
		cmd: ["rm", "hydra-config-schema.json"]
	}
}
