package talos

import (
	"list"
	"strings"
	"encoding/json"
	"encoding/yaml"
	"tool/exec"
	"tool/http"
	"tool/cli"
)

host:           string @tag(host,var=hostname)
targetNodeName: string @tag(node)

targetNode: t.Node[targetNodeName]
targetNodeConfig: exec.Run & {#genConfig, $node: targetNode}

secrets: exec.Run & {
	cmd: ["sops", "decrypt", "secrets.yaml"]
	stdout: string
}

talosVersion: {
	req: http.Get & {
		url: "https://api.github.com/repos/siderolabs/talos/releases"
		response: {
			statusCode: 200
			body:       string & =~".*tag_name.*"
			value:      json.Unmarshal(body)
		}
	}
	value: req.response.value[0].tag_name
}

// wrapper for talosctl with nodes populated. useage -t cmd="get disks" -t role=worker
command: "talosctl": {
	args: string @tag(cmd)
	role: string @tag(role)

	nodes: [
		for name, node in t.Node if role == _|_ || node.role[role] != _|_ {name},
	]

	run: exec.Run & {
		cmd: list.Concat([
			["talosctl", "--nodes", strings.Join(nodes, ",")],
			strings.Split(args, " "),
		])
	}
}

// generate a talosconfig
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
			["--config-patch", yaml.Marshal(patch)]
		}]),
	])
	stdout: string

	...
}

command: "adopt": {
	apply: exec.Run & {
		stdin: targetNodeConfig.stdout
		cmd: ["talosctl", "apply-config",
			"--context", clusterName,
			"--nodes", targetNode.ip,
			"--file", "/dev/stdin",
			"--insecure",
		]
	}
}

// run cue cmd apply for all nodes
command: "apply-all": {
	let commands = [for name, _ in t.Node {"cue cmd apply -t node=\(name)"}]
	exec.Run & {
		cmd: ["sh", "-c", strings.Join(commands, " && ")]
	}
}

// run talosctl apply-config and talosctl upgrade for -t node
command: "apply": {
	apply: exec.Run & {
		stdin: targetNodeConfig.stdout
		cmd: ["talosctl", "apply-config",
			"--context", clusterName,
			"--nodes", targetNodeName,
			"--file", "/dev/stdin",
		]
	}

	schematic: http.Post & {
		url: "https://factory.talos.dev/schematics"
		request: body:  json.Marshal(targetNode.schematic)
		response: body: string
		response: value: json.Unmarshal(response.body) & {id: string}
	}

	upgradePrint: cli.Print & {
		$after: [apply]
		text: """
		Upgrading to factory image "factory.talos.dev/metal-installer/\(schematic.response.value.id):\(talosVersion.value)"
		"""
	}

	upgrade: exec.Run & {
		$after: [apply]
		cmd: ["talosctl", "upgrade",
			"--context", clusterName,
			"--nodes", targetNodeName,
			"--image", "factory.talos.dev/metal-installer/\(schematic.response.value.id):\(talosVersion.value)",
			"--debug",
		]
	}
}

// all-in-one pixiecore with automatic config application
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
			schematics: {
				for _, node in t.Node {
					let str = json.Marshal(node.schematic)
					(str): http.Post & {
						url: "https://factory.talos.dev/schematics"
						request: body:  str
						response: body: string
						response: value: json.Unmarshal(response.body) & {id: string}
					}
				}
			}

			for _, node in t.Node {
				(node.mac): {
					schematicId: schematics[json.Marshal(node.schematic)].response.value.id

					let factoryImageBase = "https://factory.talos.dev/image/\(schematicId)/\(talosVersion.value)"

					body: json.Marshal({
						kernel: "\(factoryImageBase)/kernel-amd64"
						initrd: ["\(factoryImageBase)/initramfs-amd64.xz"]
						cmdline: {
							"console":        "tty0"
							"talos.platform": "metal"
							"talos.config": url: configEndpoint // pixiecore translated
						}
					})

					print: cli.Print & {
						text: "boot spec for \(node.mac): \(body)"
					}
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
		cmd: ["sudo", "--non-interactive", "pixiecore", "api",
			"http://localhost:8080",
			// "--dhcp-no-bind",
			"--port=9734",
			"--debug"]
	}
}
