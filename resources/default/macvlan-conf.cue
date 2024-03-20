package kube

import "encoding/json"

k: NetworkAttachmentDefinition: "macvlan-conf": spec: config: json.Marshal({
	cniVersion: "0.3.0"
	plugins: [{
		type:   "macvlan"
		master: "eno1"
		mode:   "bridge"
		ipam: {
			type: "dhcp"
			provide: [{
				option:  "host-name"
				fromArg: "K8S_POD_NAME"
			}]
		}
	}, {
		type: "tuning"
		capabilities: mac: true
	}]
})
