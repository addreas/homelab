package kube

import "encoding/json"

k: StatefulSet: "hass-matter": spec: {
	template: {
		metadata: annotations: "k8s.v1.cni.cncf.io/networks": json.Marshal([{
			name:      "iot-bridge"
			interface: "net1"
			mac:       "02:00:00:00:00:05"
		}])
		spec: {
			containers: [{
				name:  "matter-server"
				image: "ghcr.io/matter-js/matterjs-server:stable"
				args: [
					"--storage-path", "/data",
					"--primary-interface", "net1",
					"--ble-proxy",
					"--log-level", "debug",
				]
				env: [{name: "ENABLE_TEST_NET_DCL", value: "true"}]
				ports: [{containerPort: 5580}]
				readinessProbe: {
					httpGet: {
						path: "/health"
						port: 5580
					}
					initialDelaySeconds: 60
					periodSeconds:       15
				}
				volumeMounts: [{
					name:      "data"
					mountPath: "/data"
				}]
				resources: limits: {
					cpu:    "500m"
					memory: "1Gi"
				}
			}]
		}
	}
	volumeClaimTemplates: [{
		metadata: name: "data"
		spec: resources: requests: storage: "1Gi"
	}]
}

k: Service: "hass-matter": {}
