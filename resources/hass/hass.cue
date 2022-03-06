package kube

import (
	"crypto/md5"
	"encoding/hex"
	"github.com/addreas/homelab/util"
)

k: StatefulSet: hass: {
	spec: {
		template: {
			metadata: {
				annotations: "k8s.v1.cni.cncf.io/networks": "macvlan-conf"
				labels: "config-hash":                      hex.Encode(md5.Sum(k.ConfigMap."hass-config".data."configuration.yaml"))
			}
			spec: {
				initContainers: [util.copyStatic & {
					volumeMounts: [{
						name:      "config"
						mountPath: "/config"
					}, {
						name:      "hass-config"
						mountPath: "/static/config"
					}]
				}]
				containers: [{
					name:  "hass"
					image: "ghcr.io/home-assistant/home-assistant:2022.3.1"
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
						value: "postgresql://$(POSTGRES_USER):$(POSTGRES_PASSWORD)@hass-postgres/hass"
					}]
					ports: [{
						containerPort: 8123
					}]
					volumeMounts: [{
						name:      "config"
						mountPath: "/config"
					}, {
						name:      "nfs-videos"
						mountPath: "/media/videos"
					}]
				}]
				volumes: [{
					name: "hass-config"
					projected: sources: [{
						configMap: name: "hass-config"
					}, {
						secret: name: "hass-gcp-credential-json"
					}]
				}, {
					name: "nfs-videos"
					nfs: {
						path:   "/export/videos"
						server: "sergio.localdomain"
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

k: Service: hass: spec: ports: [{
	name: "http"
	port: 8123
}]

k: ServiceMonitor: hass: spec: endpoints: [{
	port:     "http"
	interval: "60s"
	path:     "/api/prometheus"
	bearerTokenSecret: {
		name: "hass-prometheus-api-key"
		key:  "key"
	}
}]

k: Ingress: hass: {}
