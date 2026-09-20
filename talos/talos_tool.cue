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

host: string @tag(host,var=hostname)

talosVersion: #githubLatest & {req: http.Get, $repo: "siderolabs/talos"}
// talosVersion: value: "v1.14.1"
k8sVersion: #githubLatest & {req: http.Get, $repo: "kubernetes/kubernetes"}
// k8sVersion: value: "v1.36.2"

secrets: exec.Run & {
	cmd: ["sops", "decrypt", "secrets.yaml"]
	stdout: string
}

targetSchematics: {
	for name, node in targetNodes {
		let str = json.Marshal(node.spec.schematic)
		(str): {
			post: http.Post & {
				url: "https://factory.talos.dev/schematics"
				request: body:  str
				response: body: string
				response: value: json.Unmarshal(response.body) & {id: string}
			}

			id: post.response.value.id

			installImage: "factory.talos.dev/metal-installer/\(id):\(talosVersion.value)"

			factoryImageBase: "https://factory.talos.dev/image/\(id)/\(talosVersion.value)"
			cmdlineGet: http.Get & {
				url: "\(factoryImageBase)/cmdline-metal-amd64"
				response: body: string
			}

			bootSpec: {
				kernel: "\(factoryImageBase)/kernel-amd64"
				initrd: ["\(factoryImageBase)/initramfs-amd64.xz"]
				cmdline: cmdlineGet.response.body
				// let configEndpoint = "http://\(host)\(command.boot.configServer.listenAddr)\(command.boot.configServer.routing.path)"
				// cmdline: #"\(cmdlineGet.response.body) talos.config={{ URL "\#(configEndpoint)" }}"#
			}
		}
	}
}

targetNodes: [Name=string]: {
	spec: t.Node[Name]

	schematic: targetSchematics[json.Marshal(spec.schematic)]

	machineConfig: exec.Run & {

		outputType: *"worker" | string
		if list.Contains(spec.roles, "control-plane") {
			outputType: "controlplane"
		}

		stdin: secrets.stdout

		cmd: list.Concat([
			["talosctl", "gen", "config",
				clusterName,
				"https://\(apiHost):6443",
				"--with-secrets", "/dev/stdin",
				// "--talos-version", talosVersion.value,
				"--install-image", schematic.installImage,
				"--kubernetes-version", k8sVersion.value,
				"--with-docs", "false",
				"--with-examples", "false",
				"--with-cluster-discovery", "false",
				"--output-types", outputType,
				"--output", "-",
			],
			list.Concat([for patch in spec.patches {
				["--config-patch", yaml.Marshal(patch)]
			}]),
		])

		stdout: string
	}
}

targetNodeName:  string @tag(node)
targetNodesRole: string @tag(role)

if targetNodeName != _|_ {
	targetNodes: (targetNodeName): _
}

if targetNodesRole != _|_ {
	for name, node in t.Node if list.Contains(node.roles, targetNodesRole) {
		targetNodes: (name): _
	}
}

targetNodeByMAC: {for name, node in targetNodes {(node.mac): node}}

// wrapper for talosctl with nodes populated. usage -t cmd="get disks" -t role=worker
command: "talosctl": {
	args: string @tag(cmd)

	run: exec.Run & {
		cmd: list.Concat([
			["talosctl", "--nodes", strings.Join([for node in targetNodes {node.spec.ip}], ",")],
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
	for name, node in targetNodes {
		apply: (name): exec.Run & {
			stdin: node.machineConfig.stdout
			cmd: ["talosctl", "apply-config",
				"--context", clusterName,
				"--nodes", node.spec.ip,
				"--file", "/dev/stdin",
				"--insecure",
			]
		}
	}
}

command: "dump-config": cli.Print & {text: targetNodes[targetNodeName].machineConfig.stdout}

// run talosctl apply-config and talosctl upgrade for -t node
command: "apply-and-upgrade": {
	for name, node in targetNodes {
		(name): {
			apply: exec.Run & {
				stdin: node.machineConfig.stdout
				cmd: ["talosctl", "apply-config",
					"--context", clusterName,
					"--nodes", name,
					"--file", "/dev/stdin",
				]
			}
			upgrade: exec.Run & {
				$after: [apply]
				cmd: ["talosctl", "upgrade",
					"--context", clusterName,
					"--nodes", name,
					"--image", node.schematic.installImage,
					"--debug",
				]
			}
		}
	}
}

// boot api: machineconfig + bootspec servers both on :8080 (separate paths); pixiecore itself runs in-cluster (pixiecore.yaml)
command: "boot": {

	configServer: http.Serve & {
		listenAddr: ":8080"
		routing: path: "/v1/machineconfig/{mac}"
		request: pathValues: mac: string
		response: body: targetNodeByMAC[request.pathValues.mac].machineConfig.stdout
	}

	pixieServer: http.Serve & {
		listenAddr: ":8080"
		routing: path: "/v1/boot/{mac}"
		request: pathValues: mac: string
		response: body: json.Marshal(targetNodeByMAC[request.pathValues.mac].schematic.bootSpec)
	}

	// pixiecore: exec.run & {
	// 	cmd: ["sudo", "--non-interactive", "pixiecore", "api",
	// 		"http://localhost:8080",
	// 		// "--dhcp-no-bind",
	// 		"--port=9734",
	// 		"--debug"]
	// }
}

command: "wol": {
	runner: string @tag(runner)
	runner: *"talos-hz2-2oi" | string

	run: exec.Run & {
		cmd: ["talosctl", "-n", runner, "debug", "nixery.dev/wakeonlan",
			"--args", "/bin/wakeonlan", "--args", targetNodes[targetNodeName].mac]
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
