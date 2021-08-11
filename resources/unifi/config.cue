package kube

import "encoding/json"

k: ConfigMap: "config-gateway-json": data: {
	"config.gateway.json": json.Marshal({
		system: "static-host-mapping": "host-name": {
			"setup.ubnt.com": {
				alias: ["setup"]
				inet: ["192.168.1.1"]
			}
			"nucles.localdomain": {
				alias: ["nucles"]
				inet: ["192.168.1.2"]
			}
		}
		protocols: bgp: "64512": {
			"parameters": "router-id": "192.168.1.1"
			"neighbor": {
				"192.168.1.11": "remote-as": "64512"
				"192.168.1.12": "remote-as": "64512"
				"192.168.1.13": "remote-as": "64512"
			}
		}

	})
}

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
