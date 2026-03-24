package talos

import (
	"list"
	"regexp"
	"encoding/json"
	"tool/exec"
	"tool/http"
	"tool/cli"
)

host: string @tag(host,var=hostname)

secrets: exec.Run & {
	cmd: ["sops", "decrypt", "secrets.yaml"]
	stdout: string
}

talosVersion: exec.Run & {
	cmd: ["talosctl", "version", "--client", "--short"]
	stdout:  string
	_parsed: regexp.Find(#"v.*"#, stdout)
}

command: "talosconfig": exec.Run & {
	stdin: secrets.stdout
	cmd: ["talosctl", "gen", "config",
		clusterName,
		"https://\(apiHost):6443",
		"--with-secrets", "/dev/stdin",
		"--output-type", "talosconfig",
	]
}

#genConfig: {
	$node: #NodeSpec

	outputType: *"worker" | string
	if $node.role["control-plane"] != _|_ {
		outputType: "controlplane"
	}

	$after: [secrets]
	stdin: secrets.stdout
	cmd: list.Concat([
		["talosctl", "gen", "config",
			clusterName,
			"https://\(apiHost):6443",
			"--with-secrets", "/dev/stdin",
			"--output-types", outputType,
			"--output", "-",
		],
		list.Concat([for patch in $node.patches {
			["--config-patch", patch]
		}]),
	])
	stdout: string

	...
}

command: "apply": {
	$nodeName: string @tag(node)
	$nodeTag:  string @tag(tag) // TODO what

	node: t.Node[$nodeName]

	config: exec.Run & {#genConfig, $node: node}

	apply: exec.Run & {
		stdin: config.stdout
		cmd: ["talosctl", "apply-config",
			"--context", clusterName,
			"--nodes", $nodeName,
			"--file", "/dev/stdin",
			"--mode", "no-reboot",
		]
		mustSucceed: false
		success:     bool
	}
	if !apply.success {
		applyStaged: exec.Run & {
			stdin: config.stdout
			cmd: ["talosctl", "apply-config",
				"--context", clusterName,
				"--nodes", $nodeName,
				"--file", "/dev/stdin",
				"--mode", "staged",
			]
		}
		// label reboot-required
	}

	schematic: http.Post & {
		url: "https://factory.talos.dev/schematics"
		request: body:  json.Marshal(node.schematic)
		response: body: string
		_json: json.Unmarshal(response.body) & {id: string}
	}

	upgrade: exec.Run & {
		cmd: ["talosctl", "upgrade",
			"--context", clusterName,
			"--nodes", $nodeName,
			"--image", "factory.talos.dev/metal-installer/\(schematic._json.id):\(talosVersion._parsed)",
			"--stage",
		]
		// label reboot required
	}
}

command: "boot": {
	configEndpoint: "http://\(host):8080/v1/machineconfig/{mac}"
	print: cli.Print & {
		text: "exposing config endpoint \(configEndpoint)"
	}

	configServer: {
		configs: {
			for _, node in t.Node {
				(node.mac): exec.Run & {#genConfig, $node: node}
			}
		}

		serve: http.Serve & {
			listenAddr: ":8080"
			routing: path: "/v1/machineconfig/{mac}"
			request: pathValues: mac: string
			response: body: configs[request.pathValues.mac].stdout
		}
	}

	pixieServer: {
		configs: {
			for _, node in t.Node {
				(node.mac): {
					schematic: http.Post & {
						url: "https://factory.talos.dev/schematics"
						request: body:  json.Marshal(node.schematic)
						response: body: string
						_json: json.Unmarshal(response.body) & {id: string}
					}

					let factoryImageBase = "https://factory.talos.dev/image/\(schematic._json.id)/\(talosVersion._parsed)"

					factoryCmdline: http.Get & {
						url: "\(factoryImageBase)/cmdline-metal-amd64"
						response: body: string
					}

					body: json.Marshal({
						kernel:  "\(factoryImageBase)/kernel-amd64"
						initrd:  "\(factoryImageBase)/initramfs-amd64.xz"
						cmdline: "\(factoryCmdline.response.body) talos.config=\(configEndpoint)"
					})
				}
			}
		}

		serve: http.Serve & {
			listenAddr: ":8080"
			routing: path: "/v1/boot/{mac}"
			request: pathValues: mac: string
			response: body: configs[request.pathValues.mac].body
		}
	}

	pixiecore: exec.Run & {
		cmd: ["pixiecore", "api",
			"http://localhost:8080",
			"--dhcp-no-bind",
			"--port=9734",
			"--debug"]
	}
}
