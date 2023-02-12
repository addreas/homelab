package kube

import "encoding/json"

k: ConfigMap: "config-gateway-json": data: {
	"config.gateway.json": json.Marshal({
		service: "dns": "forwarding": {
			"options": [
				"ptr-record=1.1.168.192.in-addr.arpa,USG",
				"all-servers",
				"cname=unifi.localdomain,unifi",
				"resolv-file=/etc/resolv.conf.dhclient-new-eth0",
				"server=1.1.1.1",
				"host-record=unifi,192.168.10.185",
				"cname=nucles.localdomain,sergio.localdomain",
			]
		}
		// system: "static-host-mapping": "host-name": {
		//  "nucles.localdomain": {
		//   alias: ["nucles"]
		//   inet: ["192.168.1.2"]
		//  }
		// }
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
