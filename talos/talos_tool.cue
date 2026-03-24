package talos

import (
	"list"
	"regexp"
	"strings"
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

command: "apply-all": {
	let commands = [for name, _ in t.Node {"cue cmd apply -t node=\(name)"}]
	exec.Run & {
		cmd: ["sh", "-c", strings.Join(commands, " && ")]
	}
}

command: "apply": {
	$nodeName: string @tag(node)

	config: exec.Run & {#genConfig, $node: t.Node[$nodeName]}

	// printConfig: cli.Print & {text: config.stdout}

	apply: exec.Run & {
		stdin: config.stdout
		cmd: ["talosctl", "apply-config",
			"--context", clusterName,
			"--nodes", $nodeName,
			"--file", "/dev/stdin",
			"--mode", "staged",
		]
	}
	// if !apply.success {
	// 	applyStaged: exec.Run & {
	// 		stdin: config.stdout
	// 		cmd: ["talosctl", "apply-config",
	// 			"--context", clusterName,
	// 			"--nodes", $nodeName,
	// 			"--file", "/dev/stdin",
	// 			"--mode", "staged",
	// 		]
	// 	}
	// 	// label reboot-required
	// }

	schematic: http.Post & {
		url: "https://factory.talos.dev/schematics"
		request: body:  json.Marshal(node.schematic)
		response: body: string
		_json: json.Unmarshal(response.body) & {id: string}
	}

	print: cli.Print & {
		text: """
		Upgrading to factory image "factory.talos.dev/metal-installer/\(schematic._json.id):\(talosVersion._parsed)"
		"""
	}

	upgrade: exec.Run & {
		$after: [apply]
		cmd: ["talosctl", "upgrade",
			"--context", clusterName,
			"--nodes", $nodeName,
			"--stage",
			"--image", "factory.talos.dev/metal-installer/\(schematic._json.id):\(talosVersion._parsed)",
			"--debug",
		]
		// label reboot required
	}

	kubeUpgrade: exec.Run & {
		$after: [apply]
		cmd: ["talosctl", "upgrade-k8s",
			"--context", clusterName,
			"--nodes", $nodeName,
		]
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
