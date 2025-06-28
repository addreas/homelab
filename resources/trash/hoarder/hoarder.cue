package kube

k: Deployment: "hoarder-web": spec: template: spec: {
	containers: [{
		env: [{
			name:  "MEILI_ADDR"
			value: "http://meilisearch:7700"
		}, {
			name:  "BROWSER_WEB_URL"
			value: "http://chrome:9222"
		}, {
			name:  "DATA_DIR"
			value: "/data"
		}]
		envFrom: [{
			secretRef: name: "hoarder-secrets"
		}, {
			configMapRef: name: "hoarder-configuration"
		}]
		image:           "ghcr.io/hoarder-app/hoarder:release"
		imagePullPolicy: "Always"
		ports: [{name: "web", containerPort: 3000}]
		volumeMounts: [{
			mountPath: "/data"
			name:      "data"
		}]
	}]
	volumes: [{
		name: "data"
		persistentVolumeClaim: claimName: "data-pvc"
	}]
}

k: Service: "hoarder-web": spec: {}

k: PersistentVolumeClaim: "data-pvc": spec: {
	accessModes: ["ReadWriteOnce"]
	resources: requests: storage: "1Gi"
}
