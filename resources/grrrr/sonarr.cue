package kube

k: StatefulSet: sonarr: {
	spec: {
		template: {
			metadata: labels: "vpn-egress": "client"
			spec: {
				containers: [{
					name:            "sonarr"
					image:           "nixery.addem.se/sonarr"
					imagePullPolicy: "Always"
					command: ["NzbDrone", "--nobrowser", "--data=/config"]
					env: [{
						name:  "COMPlus_EnableDiagnostics"
						value: "0"
					}]
					ports: [{
						name:          "http"
						containerPort: 8989
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
					image:           "nixery.addem.se/exportarr"
					imagePullPolicy: "IfNotPresent"
					command: ["exportarr", "sonarr"]
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
				}]
				volumes: [{
					name: "sergio-videos"
					persistentVolumeClaim: claimName: "sergio-videos"
				}, {
					name: "config"
					persistentVolumeClaim: claimName: "sergio-sonarr-config"
				}]
			}
		}
	}
}

k: PersistentVolumeClaim: "sergio-sonarr-config": spec: resources: requests: storage: "1Gi"
k: PersistentVolume: "sergio-sonarr-config": spec: local: path: "/mnt/solid-data/sonarr-config"

k: Service: sonarr: {}

k: ServiceMonitor: sonarr: spec: endpoints: [{
	port:     "metrics"
	interval: "60s"
}]

k: Ingress: sonarr: _authproxy: true

k: GrafanaDashboard: "sonarr": spec: {
	source: remote: grafanaCom: id: 12530
	datasources: [{
		datasourceRef: name:      "prometheus"
		datasourceRef: namespace: "monitoring"
		inputName: "DS_PROMETHEUS"
	}]
	plugins: [{
		name:    "grafana-piechart-panel"
		version: "1.6.1"
	}]
}
