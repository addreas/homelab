package kube

k: StatefulSet: sonarr: {
	spec: {
		template: {
			metadata: labels: "vpn-egress": "client"
			spec: {
				containers: [{
					name:            "sonarr"
					image:           "ghcr.io/hotio/sonarr"
					imagePullPolicy: "Always"
					command: ["sh", "-c"]
					args: ["""
						source /etc/cont-init.d/01-cert-sync
						exec mono --debug $APP_DIR/bin/Sonarr.exe --nobrowser --data="$CONFIG_DIR"
						"""]
					ports: [{
						name:          "http"
						containerPort: 8989
					}]
					volumeMounts: [{
						mountPath: "/config"
						name:      "config"
					}, {
						mountPath: "/videos"
						name:      "nfs-videos"
					}, {
						mountPath: "/usr/share/.mono"
						name:      "mono-dir"
					}]
					resources: {
						limits: {
							cpu:    "1500m"
							memory: "2Gi"
						}
						requests: {
							cpu:    "100m"
							memory: "512Mi"
						}
					}
				}, {
					name:            "exportarr"
					image:           "ghcr.io/onedr0p/exportarr:master"
					imagePullPolicy: "IfNotPresent"
					args: ["sonarr"]
					env: [{
						name:  "PORT"
						value: "9707"
					}, {
						name:  "URL"
						value: "http://localhost:8989"
					}, {
						name: "APIKEY"
						valueFrom: secretKeyRef: {
							name: "sonarr-apikey"
							key:  "apikey"
						}
					}]
					ports: [{
						name:          "metrics"
						containerPort: 9707
					}]
					resources: limits: {
						cpu:    "200m"
						memory: "64Mi"
					}
					volumeMounts: [{
						name:      "home-nonroot"
						mountPath: "/home/nonroot"
					}]
				}]
				volumes: [{
					name: "nfs-videos"
					nfs: {
						path:   "/export/videos"
						server: "sergio.localdomain"
					}
				}, {
					name: "home-nonroot"
					emptyDir: {}
				}, {
					name: "mono-dir"
					emptyDir: {}
				}]
			}
		}
		volumeClaimTemplates: [{
			metadata: name: "config"
			spec: {
				resources: requests: storage: "5Gi"
				accessModes: ["ReadWriteOnce"]
			}
		}]
	}
}

k: Service: sonarr: {}

k: ServiceMonitor: sonarr: spec: endpoints: [{
	port:     "metrics"
	interval: "60s"
}]

k: Ingress: sonarr: _authproxy: true

k: GrafanaDashboard: "sonarr": spec: {
	grafanaCom: id: 12530
	datasources: [{
		datasourceName: "Prometheus"
		inputName:      "DS_PROMETHEUS"
	}]
	plugins: [{
		name:    "grafana-piechart-panel"
		version: "1.6.1"
	}]
}
