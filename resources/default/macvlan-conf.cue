package kube

import "encoding/json"

k: NetworkAttachmentDefinition: "macvlan-conf": spec: config: json.Marshal({
	cniVersion: "0.3.0"
	type:       "macvlan"
	master:     "eno1"
	mode:       "bridge"
	ipam: {
		type: "dhcp"
		provide: [{
			// requires cni-plugins > 1.0.1 (unreleased)
			option:  "host-name"
			fromArg: "K8S_POD_NAME"
		}]
	}
})
