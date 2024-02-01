package kube

k: StatefulSet: radarr: {
	spec: {
		template: {
			metadata: labels: "vpn-egress": "client"
			spec: {
				containers: [{
					name:  "radarr"
					image: "nixery.addem.se/shell/radarr"
					command: ["Radarr", "--nobrowser", "--data=/config"]
					env: [{
						name:  "COMPlus_EnableDiagnostics"
						value: "0"
					}]
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
					name:  "exportarr"
					image: "nixery.addem.se/exportarr"
					command: ["exportarr", "radarr"]
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
				}]
				volumes: [{
					name: "sergio-videos"
					persistentVolumeClaim: claimName: "sergio-videos"
				}, {
					name: "config"
					persistentVolumeClaim: claimName: "sergio-radarr-config"
				}]
			}
		}
	}
}

k: PersistentVolumeClaim: "sergio-radarr-config": spec: resources: requests: storage: "5Gi"
k: PersistentVolume: "sergio-radarr-config": spec: local: path: "/mnt/solid-data/radarr-config"

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
		datasourceRef: name:      "prometheus"
		datasourceRef: namespace: "monitoring"
		inputName: "DS_RANCHER_MONITORING"
	}]
	plugins: [{
		name:    "grafana-piechart-panel"
		version: "1.6.1"
	}]
}
