package kube

import (
	"tool/exec"
	"tool/file"
)

command: "kratos-config-schema": task: {
	kratosSchema: exec.Run & {
		cmd: [
			"curl",
			"-sSL",
			"https://raw.githubusercontent.com/ory/kratos/\(githubReleases["ory/kratos"])/embedx/config.schema.json",
		]
		stdout: string
	}
	otelxSchema: exec.Run & {
		cmd: [
			"curl",
			"-sSL",
			"https://raw.githubusercontent.com/ory/x/master/otelx/config.schema.json",
		]
		stdout: string
	}
	kratosSchemaJson: exec.Run & {
		cmd: [
			"jq",
			"""
				. as [$kratosSchema, $otelxSchema]
				| .[0]
				| del(.definitions.selfServiceWebHook.properties.config.properties.additionalProperties)
				| del(.properties.courier.properties.sms.properties.request_config.properties.additionalProperties)
				| del(.required[] | select(. == "dsn"))
				| .definitions.OtelxTracingConfig = $otelxSchema
				| .properties.tracing["$ref"] = "#/definitions/OtelxTracingConfig"
				""",
		]
		stdin:  "[\(kratosSchema.stdout), \(otelxSchema.stdout)]"
		stdout: string
	}
	writeKratosSchemaJson: file.Create & {
		filename: "kratos-config-schema.json"
		contents: kratosSchemaJson.stdout
	}
	importKratosSchema: exec.Run & {
		$after: [writeKratosSchemaJson]
		cmd: [
			"cue",
			"import",
			"-p", "kube",
			"-l", "#KratosConfigSchema:",
			"-f",
			"jsonschema",
			"kratos-config-schema.json",
		]
	}
	rm: exec.Run & {
		$after: [importKratosSchema]
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
