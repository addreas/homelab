package kube

import "github.com/addreas/homelab/util"

k: StatefulSet: hass: {
	_selector: "app": "hass"
	spec: {
		template: {
			metadata: annotations: "k8s.v1.cni.cncf.io/networks":  """
			[{
				"name": "macvlan-conf",
				"default-route": ["192.168.1.1"]
			}]
			"""
			spec: {
				initContainers: [util.copyStatic & {
					volumeMounts: [{
						name:      "config"
						mountPath: "/config"
					}, {
						name:      "hass-static-config"
						mountPath: "/static/config"
					}]
				}]
				volumes: [{
					name: "hass-static-config"
					projected: sources: [{
						configMap: name: "hass-configuration-yaml"
						secret: name: "hass-gcp-credential-json"
					}]
				}]
				containers: [{
					name:  "hass"
					image: "ghcr.io/linuxserver/homeassistant:version-2021.3.4"
					resources: {
						limits: {
							cpu:                             "500m"
							memory:                          "2Gi"
							"addem.se/dev_deconz_conbee_ii": "1"
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
				}, {
					name:  "zwavejs"
					image: "kpine/zwave-js-server:latest"
					env: [{
						name: "NETWORK_KEY"
						valueFrom: secretKeyRef: {
							name: "zwave-network-key"
							key:  "key"
						}
					}, {
						name:  "USB_PATH"
						value: "/dev/aeotec-z-stick"
					}, {
						name:  "LOGLEVEL"
						value: "info"
					}]
					resources: {
						limits: {
							"addem.se/dev_aeotec_zstick": "1"
						}
					}
				}]
			}
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
