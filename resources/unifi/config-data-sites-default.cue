package kube

import "encoding/json"

k: ConfigMap: "config-data-sites-default": data: {
	"config.gateway.json": json.Marshal({
		system: "static-host-mapping": "host-name": {
			"setup.ubnt.com": {
				alias: ["setup"]
				inet: ["192.168.1.1"]
			}
			"nucles.localdomain": {
				alias: ["nucles"]
				inet: ["192.168.1.10"]
			}
		}
	})
}
