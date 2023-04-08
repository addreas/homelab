package kube

k: StatefulSet: radarr: {
	spec: {
		template: {
			metadata: labels: "vpn-egress": "client"
			spec: {
				containers: [{
					name:            "radarr"
					image:           "ghcr.io/hotio/radarr"
					imagePullPolicy: "Always"
					command: ["sh", "-c"]
					args: ["""
						exec $APP_DIR/bin/Radarr --nobrowser --data="$CONFIG_DIR"
						"""]
					ports: [{
						containerPort: 7878
					}]
					volumeMounts: [{
						mountPath: "/config"
						name:      "config"
					}, {
						mountPath: "/videos"
						name:      "sergio-videos"
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
					args: ["radarr"]
					env: [{
						name:  "PORT"
						value: "9707"
					}, {
						name:  "URL"
						value: "http://localhost:7878"
					}, {
						name: "APIKEY"
						valueFrom: secretKeyRef: {
							name: "radarr-apikey"
							key:  "apikey"
						}
					}]
					ports: [{
						containerPort: 9707
					}]
					resources: limits: {
						cpu:    "200m"
						memory: "128Mi"
					}
					volumeMounts: [{
						name:      "home-nonroot"
						mountPath: "/home/nonroot"
					}]
				}]
				volumes: [{
					name: "sergio-videos"
					persistentVolumeClaim: claimName: "sergio-videos"
				}, {
					name: "home-nonroot"
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

k: Service: radarr: spec: ports: [{
	name: "http"
	port: 7878
}, {
	name: "metrics"
	port: 9707
}]

k: ServiceMonitor: radarr: spec: endpoints: [{
	port:     "metrics"
	interval: "60s"
}]

k: Ingress: radarr: _authproxy: true

k: GrafanaDashboard: "radarr": spec: {
	source: remote: grafanaCom: id: 12896
	datasources: [{
		datasourceName: "Prometheus"
		inputName:      "DS_RANCHER_MONITORING"
	}]
	plugins: [{
		name:    "grafana-piechart-panel"
		version: "1.6.1"
	}]
}
