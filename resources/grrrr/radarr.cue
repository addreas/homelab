package kube

k: StatefulSet: radarr: {
	spec: {
		template: {
			metadata: labels: "vpn-egress": "client"
			spec: {
				containers: [{
					name:            "radarr"
					image:           "lscr.io/linuxserver/radarr:latest"
					imagePullPolicy: "Always"
					command: ["/app/radarr/bin/Radarr", "-nobrowser", "-data=/config"]
					ports: [{
						containerPort: 7878
					}]
					volumeMounts: [{
						mountPath: "/config"
						name:      "config"
					}, {
						mountPath: "/videos"
						name:      "videos"
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
				}]
				volumes: [{
					name: "videos"
					persistentVolumeClaim: claimName: "videos"
				}, {
					name: "config"
					persistentVolumeClaim: claimName: "radarr-config"
				}]
			}
		}
	}
}

k: PersistentVolumeClaim: "radarr-config": spec: resources: requests: storage: "5Gi"

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
