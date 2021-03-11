package kube

import "encoding/json"

k: NetworkAttachmentDefinition: "macvlan-conf": {
	spec: {
		config: json.Marshal({
			cniVersion: "0.3.0"
			type:       "macvlan"
			master:     "eno1"
			mode:       "bridge"
			ipam: type: "dhcp"
		})
	}
}
