package kube

import (
	"tool/exec"
	"tool/file"
	"tool/http"
)

#FixTracing: {
	schema: string
	otelxSchema: http.Get & {
		url: "https://raw.githubusercontent.com/ory/x/master/otelx/config.schema.json"
		response: body: string
	}
	setTracingConf: exec.Run & {
		cmd: [
			"jq",
			"""
				. as [$schema, $otelxSchema]
				| .[0]
				| .definitions.OtelxTracingConfig = $otelxSchema
				| del(.definitions.OtelxTracingConfig["$schema"])
				| .properties.tracing["$ref"] = "#/definitions/OtelxTracingConfig"
				""",
		]
		stdin:  "[\(schema), \(otelxSchema.response.body)]"
		stdout: string
	}
	output: setTracingConf.stdout
}

command: "kratos-config-schema": task: {
	kratosSchema: http.Get & {
		url: "https://raw.githubusercontent.com/ory/kratos/\(githubReleases["ory/kratos"])/embedx/config.schema.json"
		response: body: string
	}
	fixTracing: #FixTracing & {
		schema: kratosSchema.response.body
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
	hydraSchema: http.Get & {
		url: "https://raw.githubusercontent.com/ory/hydra/\(githubReleases["ory/hydra"])/spec/config.json"
		response: body: string
	}
	fixTracing: #FixTracing & {
		schema: hydraSchema.response.body
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
