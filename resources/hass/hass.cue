package kube

import (
	"crypto/md5"
	"encoding/hex"
	"encoding/json"
	"github.com/addreas/homelab/util"
)

k: StatefulSet: hass: spec: template: metadata:
	annotations: "k8s.v1.cni.cncf.io/networks": json.Marshal([{
		name: "macvlan-conf"
		mac:  "02:00:00:00:00:03" // https://en.wikipedia.org/wiki/MAC_address#IEEE_802c_local_MAC_address_usage
	}])

k: StatefulSet: hass: spec: {
	template: {
		metadata: labels: "config-hash": hex.Encode(md5.Sum(k.ConfigMap."hass-config".data."configuration.yaml"))
		spec: {
			initContainers: [
				util.macvlanDefaultRouteFix,
				util.copyStatic & {
					volumeMounts: [{
						name:      "config"
						mountPath: "/config"
					}, {
						name:      "hass-config"
						mountPath: "/static/config"
					}]
				},
			]
			containers: [{
				image: "ghcr.io/home-assistant/home-assistant:\(githubReleases."home-assistant/core")"
				command: ["hass", "-c", "/config"]
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
					value: "postgresql://$(POSTGRES_USER):$(POSTGRES_PASSWORD)@hass-postgres-new/hass"
				}, {
					name:  "HOME"
					value: "/config"
				}]
				ports: [{
					name:          "http"
					containerPort: 8123
				}]
				volumeMounts: [{
					name:      "config"
					mountPath: "/config"
				}]
			}]
			volumes: [{
				name: "hass-config"
				projected: sources: [{
					configMap: name: "hass-config"
				}, {
					secret: name: "hass-gcp-credential-json"
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

k: Service: hass: {}

k: Ingress: hass: {}

k: ServiceMonitor: hass: spec: endpoints: [{
	port:     "http"
	interval: "60s"
	path:     "/api/prometheus"
	bearerTokenSecret: {
		name: "hass-prometheus-api-key"
		key:  "key"
	}
}]
