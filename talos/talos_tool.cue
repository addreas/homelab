package talos

import (
	"strings"
	"encoding/json"
	"tool/exec"
	"tool/http"
)

secrets: exec.Run & {
	cmd: ["sops", "decrypt", "secrets.yaml"]
	stdout: string
}

command: "gen talosconfig": exec.Run & {
	cmd: ["talosctl", "gen", "config",
		clusterName,
		"https://\(apiHost):6443",
		"--with-secrets", "/dev/stdin",
		"--output-type", "talosconfig",
	]
	stdin: secrets.stdout
}

#genConfig: {
	$node: #NodeSpec

	outputType: *"worker" | string
	if $node.role["control-plane"] {
		outputType: "controlplane"
	}

	gen: exec.Run & {
		cmd: ["talosctl", "gen", "config",
			clusterName,
			"https://\(apiHost):6443",
			"--with-secrets", "/dev/stdin",
			"--config-patch", $node.patch,
			"--output-type", outputType,
			"--output", "-",
		]
		stdin:  secrets.stdout
		stdout: string
	}

	$return: gen.stdout
}

command: "apply-config": {
	$nodeName: string @tag(node)

	config: (#genConfig & {$node: nodes[$nodeName]}).$return

	apply: exec.Run & {
		cmd: ["talosctl", "apply-config",
			"--context", clusterName,
			"--nodes", $nodeName,
			"--file", "/dev/stdin",
		]
		stdin: config
	}
}

command: "boot": {
	configServer: {
		for node in nodes {
			config: (node.mac): (#genConfig & {$node: node}).$return
		}

		serve: http.Serve & {
			listenAddr: ":8080"
			routing: path: "/v1/talos/{mac}"
			request: pathValues: mac: string
			response: body: configServer.config[request.pathValues.mac]
		}
	}

	pixieServer: {
		talosVersion: exec.Run & {
			cmd: ["talosctl", "version", "--client", "--short"]
			stdout:  string
			_parsed: strings.Replace(stdout, "Talos ", "")
		}
		hostIp: exec.Run & {
			cmd: ["ip", "--json", "route"]
			stdout: string

			for route in json.Unmarshal(stdout) if route.dst == "default" {
				_parsed: route.prefsrc
			}
		}
		configEndpoint: "http://\(hostIp._parsed):8080/v1/talos/{mac}"

		schematic: [string]: _json: id: string
		factoryImageBase: [string]: string
		factoryCmdline: [string]: response: body: string

		for node in nodes {
			schematic: (node.mac): http.Post & {
				url: "https://factory.talos.dev/schematics"
				request: body:  json.Marshal(node.schematic)
				response: body: string
				_json: json.Unmarshal(response.body) & {id: string}
			}

			factoryImageBase: (node.mac): "https://factory.talos.dev/image/\(schematic[node.mac]._json.id)/\(talosVersion._parsed)"

			factoryCmdline: (node.mac): http.Get & {
				url: "\(factoryImageBase)/cmdline-metal-amd64"
				response: body: string
			}
		}

		serve: http.Serve & {
			listenAddr: ":8080"
			routing: path: "/v1/boot/{mac}"
			request: pathValues: "mac": string

			let mac = request.pathValues.mac

			response: body: json.Marshal({
				kernel:  "\(factoryImageBase[mac])/kernel-amd64"
				initrd:  "\(factoryImageBase[mac])/initramfs-amd64.xz"
				cmdline: "\(factoryCmdline[mac].response.body) talos.config=\(configEndpoint)"
			})
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

command: "config update": {
	// talosctl upgrade --nodes $node_name --image $"factory.talos.dev/metal-installer/($schematic_id):($talos_version)"
	// talosctl apply-config --nodes $node_name --file config.yaml
}
