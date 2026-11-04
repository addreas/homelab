@experiment(try)
package talos

groups: "base": {
	common: roles: ["base", "cilium", "talos-logs", "nvme-install-disk"]
	groups: {
		"control-plane": {
			common: roles: ["control-plane", "intel"]
			nodes: {
				"qbm0": {mac: "1c:69:7a:a0:af:3e", ip: "10.24.0.86"}
				"qbm1": {mac: "1c:69:7a:01:84:76", ip: "10.24.0.90"}
				"qbm2": {mac: "1c:69:7a:6f:c2:b8", ip: "10.24.0.94"}
			}
		}

		"worker": {
			common: roles: ["longhorn", "intel", "iot-bridge", "sandbox-runtimes"]
			nodes: {
				"qbw0": {mac: "30:24:a9:87:60:bf", ip: "10.24.0.69", roles: ["vpn-egress"]}
				"qbw1": {mac: "e8:d8:d1:54:d7:df", ip: "10.24.0.95"}
				// "qbw2": {mac: "38:22:e2:0d:85:f6", ip: "10.24.0.108"}
				// "qbw3": {mac: "84:a9:3e:10:c4:66", ip: "10.24.0.192"}
			}
		}
	}
}

t: Node: {
	for _, g1 in groups {
		try {
			for name, node in g1.nodes? {
				(name): (#MergeAppend & {in: [node, g1.common]}).out
			}
		}
		try {
			for _, g2 in g1.groups? {
				try {
					for name, node in g2.nodes? {
						(name): (#MergeAppend & {in: [node, g1.common, g2.common]}).out
					}
				}
				try {
					for _, g3 in g2.groups? {
						try {
							for name, node in g3.nodes? {
								(name): (#MergeAppend & {in: [node, g1.common, g2.common, g3.common]}).out
							}
						}
					}
				}
			}

		}
	}
}
