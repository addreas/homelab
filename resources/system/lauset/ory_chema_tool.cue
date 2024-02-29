package kube

import (
	"tool/exec"
	"tool/file"
)

#FixTracing: {
	schema: string
	otelxSchema: exec.Run & {
		cmd: [
			"curl",
			"-sSL",
			"https://raw.githubusercontent.com/ory/x/master/otelx/config.schema.json",
		]
		stdout: string
	}
	setTracingConf: exec.Run & {
		cmd: [
			"jq",
			"""
				. as [$schema, $otelxSchema]
				| .[0]
				| .definitions.OtelxTracingConfig = $otelxSchema
				| .properties.tracing["$ref"] = "#/definitions/OtelxTracingConfig"
				""",
		]
		stdin:  "[\(schema), \(otelxSchema.stdout)]"
		stdout: string
	}
	output: setTracingConf.stdout
}

command: "kratos-config-schema": task: {
	kratosSchema: exec.Run & {
		cmd: [
			"curl",
			"-sSL",
			"https://raw.githubusercontent.com/ory/kratos/\(githubReleases["ory/kratos"])/embedx/config.schema.json",
		]
		stdout: string
	}
	fixTracing: #FixTracing & {
		schema: kratosSchema.stdout
	}
	fixSchema: exec.Run & {
		cmd: [
			"jq",
			"""
				del(.definitions.selfServiceWebHook.properties.config.properties.additionalProperties)
				| del(.definitions.httpRequestConfig.properties.additionalProperties)
				| del(.properties.courier.properties.sms.properties.request_config.properties.additionalProperties)
				| del(.required[] | select(. == "dsn"))
				""",
		]
		stdin:  fixTracing.output
		stdout: string
	}
	writeKratosSchemaJson: file.Create & {
		filename: "kratos-config-schema.json"
		contents: fixSchema.stdout
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
	hydraSchema: exec.Run & {
		cmd: [
			"curl",
			"-sSL",
			"https://raw.githubusercontent.com/ory/hydra/\(githubReleases["ory/hydra"])/spec/config.json",
		]
		stdout: string
	}
	fixTracing: #FixTracing & {
		schema: hydraSchema.stdout
	}
	writeHydraSchemaJson: file.Create & {
		filename: "hydra-config-schema.json"
		contents: fixTracing.output
	}
	import: exec.Run & {
		$after: [writeHydraSchemaJson]
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
