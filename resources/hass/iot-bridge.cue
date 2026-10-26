package kube

k: NetworkAttachmentDefinition: "iot-bridge": spec: config: json.Marshal({
	cniVersion: "0.3.0"
	plugins: [{
		type:   "bridge"
		bridge: "br-iot"
		ipam: {
			type: "dhcp"
			provide: [{
				option:  "host-name"
				fromArg: "K8S_POD_NAME"
			}]
		}
	}, {
		type: "sbr"
	}, {
		type: "tuning"
		capabilities: mac: true
		sysctl: {
			"net.ipv6.conf.net1.accept_ra":                  "2"
			"net.ipv6.conf.net1.accept_ra_rt_info_max_plen": "64"
		}
	}]
})
