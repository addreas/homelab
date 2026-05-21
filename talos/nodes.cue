@experiment(try)
package talos

groups: "base": {
	common: roles: ["base"]
	groups: {
		"control-plane": {
			common: roles: ["control-plane", "intel"]
			nodes: {
				"talos-3cf-jbr": {mac: "1c:69:7a:a0:af:3e", ip: "10.24.0.86"}
				"talos-lcn-k2p": {mac: "1c:69:7a:6f:c2:b8", ip: "10.24.0.94"}
				"qb-cp-90": {mac: "1c:69:7a:01:84:76", ip: "10.24.0.90", roles: ["longhorn"]}
			}
		}

		"worker": {
			common: roles: ["worker", "longhorn", "intel"]
			nodes: {
				"talos-hz2-2oi": mac: "30:24:a9:87:60:bf"
				"talos-o1t-0lm": mac: "e8:d8:d1:54:d7:df"
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
