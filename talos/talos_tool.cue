package talos

import (
	"list"
	"strings"
	"encoding/json"
	"encoding/yaml"
	"tool/exec"
	"tool/file"
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

// wrapper for talosctl with nodes populated. usage -t cmd="get disks" -t role=worker
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

// apply initial config on node (-t node=name) in maintenance mode (ip has to be defined)
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

// apply config to every node, sequentially
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

	talosVersion: #talosVersion & {req: http.Get}
	// talosVersion: value: "v1.13.2"

	upgradePrint: cli.Print & {
		$after: [apply]
		text: """
		Running upgrade: 
		\(strings.Join(upgrade.cmd, " "))
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

// all-in-one pixiecore with automatic config fetch
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

	talosVersion: #talosVersion & {req: http.Get}

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

// bootstrap etcd + fetch kubeconfig, install cilium/multus/flux and apply resources
command: "bootstrap": {
	ciliumValues: {
		ipam: mode: "kubernetes"
		kubeProxyReplacement: true
		securityContext: capabilities: {
			ciliumAgent:      "CHOWN,KILL,NET_ADMIN,NET_RAW,IPC_LOCK,SYS_ADMIN,SYS_RESOURCE,DAC_OVERRIDE,FOWNER,SETGID,SETUID"
			cleanCiliumState: "NET_ADMIN,SYS_ADMIN,SYS_RESOURCE"
		}
		cgroup: {
			autoMount: enabled: false
			hostRoot: "/sys/fs/cgroup"
		}
		k8sServiceHost: "localhost"
		k8sServicePort: 7445
	}

	bootstrap: exec.Run & {
		cmd: ["talosctl", "bootstrap", "--nodes", targetNodeName]
	}

	kubeconfig: exec.Run & {
		$after: [bootstrap]
		cmd: ["talosctl", "kubeconfig", "--nodes", targetNodeName]
	}

	ciliumValuesFile: file.Create & {
		filename: "cilium-values.yaml"
		contents: yaml.Marshal(ciliumValues)
	}

	cilium: exec.Run & {
		$after: [kubeconfig, ciliumValuesFile]
		cmd: ["cilium", "install", "--values", ciliumValuesFile.filename]
	}

	multus: exec.Run & {
		$after: [cilium]
		cmd: ["kubectl", "apply", "-f", "https://raw.githubusercontent.com/k8snetworkplumbingwg/multus-cni/master/deployments/multus-daemonset-thick.yml"]
	}

	flux: exec.Run & {
		$after: [cilium]
		cmd: ["flux", "install", "--toleration-keys=node-role.kubernetes.io/control-plane"]
	}

	cueController: exec.Run & {
		$after: [flux]
		cmd: ["kubectl", "apply", "-k", "https://github.com/addreas/cue-controller/config/default"]
	}

	applyResources: exec.Run & {
		$after: [cueController]
		cmd: ["cue", "cmd", "apply", "-t", "kind=CueExport", "../resources/..."]
	}
}

// cue get go the talos go types
command: "defs": {
	version: string @tag(version)
	version: *talosVersion.value | string

	talosVersion: #talosVersion & {req: http.Get}

	fetch: http.Get & {
		url: "https://raw.githubusercontent.com/siderolabs/talos/\(version)/pkg/machinery/config/types/types.go"
		response: body: string
	}

	pkgs: [for line in strings.Split(fetch.response.body, "\n")
		if strings.Contains(line, "pkg/machinery")
		if strings.Contains(line, "\"") {strings.Split(line, "\"")[1]}]

	pin: exec.Run & {
		cmd: ["go", "-C", "..", "get", "github.com/siderolabs/talos@\(version)"]
	}

	generate: exec.Run & {
		$after: [fetch, pin]
		cmd: list.Concat([["cue", "get", "go"], pkgs])
	}
}

#genConfig: {
	$node: #NodeSpec

	outputType: *"worker" | string
	if list.Contains($node.roles, "control-plane") {
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

#talosVersion: {
	req: {
		url: "https://api.github.com/repos/siderolabs/talos/releases"
		response: {
			statusCode: 200
			body:       string & =~".*tag_name.*"
			value:      json.Unmarshal(body)
			...
		}
		...
	}

	value: [for r in req.response.value if r.prerelease != true {r}][0].tag_name
}
