package kube

k: StatefulSet: hass: {
	_selector: "app": "hass"
	spec: {
		template: {
			metadata: annotations: "k8s.v1.cni.cncf.io/networks": "macvlan-conf"
			spec: containers: [{
				name:  "hass"
				image: "ghcr.io/linuxserver/homeassistant:version-2021.2.3"
				resources: {
					limits: {
						cpu:                          "500m"
						memory:                       "2Gi"
						"addem.se/dev_deconz_conbee": "1"
					}
					requests: {
						cpu:    "100m"
						memory: "256Mi"
					}
				}
				ports: [{
					containerPort: 8123
				}]
				volumeMounts: [{
					name:      "config"
					mountPath: "/config"
				}]
			}]
		}
		volumeClaimTemplates: [{
			metadata: name: "config"
			spec: {
				accessModes: ["ReadWriteOnce"]
				resources: requests: storage: "5Gi"
			}
		}]
	}
}
