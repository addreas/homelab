package talos

import (
	"list"
	"strings"
	"encoding/yaml"
	"encoding/json"
	"text/tabwriter"
	"tool/cli"
	"tool/file"
	"tool/exec"
	"tool/os"
)

#pipe: {
	args: {
		cleanupAfter: [...]
		contents: bytes | string
	}

	tmpDir: file.MkdirTemp & {path: string}

	pipeName: "\(tmpDir.path)/pipe"

	mkfifo: exec.Run & {
		cmd: ["mkfifo", pipeName]
	}

	append: file.Append & {
		filename: pipe
		contents: args.contents
	}

	cleanup: file.RemoveAll & {
		$after: $cleanupAfter
		path:   tmpDir.path
	}
}

#sopsDecryptPipe: {
	#pipe

	args: contents: decrypt.stdout
	decrypt: exec.Run & {
		cmd: ["sops", "decrypt", "secrets.yaml"]
		stdout: string
	}
}

#genConfig: {
	args: {
		cluster_name: string @tag(name)
		api_host:     string @tag(host)
		flags: [...string]
	}

	secrets: #sopsDecryptPipe & {
		args: cleanupAfter: [generateConfig]
	}

	generateConfig: exec.Run & {
		cmd: ["talosctl", "gen", "config",
			args.cluster_name,
			"https://\(args.api_host):6443",
			"--with-secrets", secrets.pipeName,
			"--config-patch", "@patches/machine.yaml",
			"--config-patch", "@patches/cluster.yaml",
			...flags,
		]
	}

}

command: "gen talosconfig": genConfig & {
	args: flags: ["--output-types", "talosconfig"]
}

command: "gen controlplane": genConfig & {
	args: flags: [
		"--config-patch", "@patches/controlplane.yaml",
		"--output-types", "controlplane",
		"--output", "config.yaml",
	]
}

command: "gen worker": genConfig & {
	args: flags: [
		"--config-patch", "@patches/worker.yaml",
		"--output-types", "worker",
		"--output", "config.yaml",
	]
}

command: "apply-config": {
	args: {
		cluster_name: string @tag(name)
		node:         string @tag(node)
	}

	config: #pipe & {
		args: content: gen.stdout
		gen: "talosctl gen config --output -" // TODO
	}

	apply: cmd.Run & {
		cmd: ["talosctl", "apply-config",
			"--context", args.cluster_name,
			"--nodes", args.node,
			"--file", config.pipeName,
		]
	}
}

command: "boot": {
	args: {
		cluster_name: string @tag(name)
		api_host:     string @tag(host)
	}

	configServer: {
		gen: #genConfig & {
			args: flags: [
				"--output", "-",
			]
		}
		serve: http.Serve & {
			listenAddr: ":8080"
			routing: path: "/talos/{mac}/config.yaml"
			request: {
				pathValues: mac: string
			}
			response: body: gen[request.pathValues.mac].stdout
		}
	}

	//     let schematic_id = open schematics/base.yaml ...$schematics
	//         | reduce { |it| merge deep --strategy append $it }

	schematicSource: {}
	schematic: http.Post & {
		url: "https://factory.talos.dev/schematics"
		request: body: json.Marshal(schematicSource)
		response: {
			body: string
			_json: json.Unmarshal(body) & {
				id: string
			}
		}
	}
	talosVersion: cmd.Run & {
		cmd: ["talosctl", "version", "--client", "--short"]
		stdout:  string
		_parsed: strings.Replace(stdout, "Talos ", "")
	}
	hostIp: cmcd.Run & {
		cmd: ["ip", "--json", "route"]
		stdout: string

		for route in json.Unmarshal(stdout) if route.dst == "default" {
			_ip: route.prefsrc
		}

	}

	factoryImageBase: "https://factory.talos.dev/image/\(schematic.response._json.id)/\(talosVersion._parsed)"

	factoryCmdline: http.Get & {
		url: "\(factoryImageBase)/cmdline-metal-amd64"
		response: body: string
	}

	configEndpoint: "http://\(hostIp._parsed.ip):8080/talos/{mac}/config.yaml"

	pixiecore: cmd.Run & {
		cmd: ["pixiecore", "boot",
			"\(factoryImage)/kernel-amd64",
			"\(factoryImage)/initramfs-amd64.xz",
			"--dhcp-no-bind",
			"--port 9734",
			"--debug",
			"--cmdline", "\(factoryCmdline) talos.config=\(configEndpoint)"]
	}

}

// Dump a yaml stream of Kubernetes resources
command: "dump-yaml": cli.Print & {
	text: yaml.MarshalStream(list.Concat([earlyResources, resources]))
}

command: "config update": {
	// talosctl upgrade --nodes $node_name --image $"factory.talos.dev/metal-installer/($schematic_id):($talos_version)"
	// talosctl apply-config --nodes $node_name --file config.yaml
}
