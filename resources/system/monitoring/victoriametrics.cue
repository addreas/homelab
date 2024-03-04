package kube

k: Deployment: victoriametrics: spec: template: spec: {
	containers: [{
		image: "victoriametrics/victoria-metrics:v1.99.0"
		args: [
			"-httpListenAddr=:8429",
			"-retentionPeriod=2y",
			"-storageDataPath=/data",
		]
		ports: [{name: "http", containerPort: 8429}]
		volumeMounts: [{
			name:      "data"
			mountPath: "/data"
		}]
		resources: {
			requests: {
				cpu:    "500m"
				memory: "512Mi"
			}
			limits: {
				cpu:    "4"
				memory: "4Gi"
			}
		}
	}]
	volumes: [{
		name: "data"
		persistentVolumeClaim: claimName: "sergio-victoriametrics"
	}]
}

k: PersistentVolumeClaim: "sergio-victoriametrics": spec: resources: requests: storage: "100Gi"
k: PersistentVolume: "sergio-victoriametrics": spec: local: path: "/mnt/solid-data/victoriametrics"

k: Service: victoriametrics: {}
k: ServiceMonitor: victoriametrics: {}

k: GrafanaDatasource: "victoriametrics": spec: {
	datasource: {
		name:      "VictoriaMetrics"
		type:      "prometheus"
		url:       "http://victoriametrics.monitoring.svc.cluster.local:8429"
		access:    "proxy"
		isDefault: false
		basicAuth: false
	}
}
