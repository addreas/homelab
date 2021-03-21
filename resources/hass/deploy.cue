package kube

import "github.com/addreas/homelab/util"

k: StatefulSet: hass: {
	spec: {
		template: {
			metadata: annotations: "k8s.v1.cni.cncf.io/networks": """
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
						secret: name:    "hass-gcp-credential-json"
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
					envFrom: [{secretRef: name: "hass-postgres-credentials"}]
					env: [{
						name:  "DB_URL"
						value: "postgres://$(POSTGRES_USER):$(POSTGRES_PASS)@hass-postgres/hass"
					}]
					ports: [{
						containerPort: 8123
					}]
					volumeMounts: [{
						name:      "config"
						mountPath: "/config"
					}]
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
