package kube

k: Deployment: meilisearch: spec: template: spec: {
	containers: [{
		image: "getmeili/meilisearch:v1.11.1"
		ports: [{
			name:          "http"
			containerPort: 7700
		}]
		env: [{
			name:  "MEILI_NO_ANALYTICS"
			value: "true"
		}]
		envFrom: [{
			secretRef: name: "hoarder-secrets"
		}, {
			configMapRef: name: "hoarder-configuration"
		}]
		volumeMounts: [{
			mountPath: "/meili_data"
			name:      "meilisearch"
		}]
	}]
	volumes: [{
		name: "meilisearch"
		persistentVolumeClaim: claimName: "meilisearch-pvc"
	}]
}

k: Service: meilisearch: spec: {}

k: PersistentVolumeClaim: "meilisearch-pvc": spec: {
	accessModes: ["ReadWriteOnce"]
	resources: requests: storage: "1Gi"
}
