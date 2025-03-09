package kube

k: Deployment: atuin: spec: template: spec: {
	containers: [{
		image: "ghcr.io/atuinsh/atuin:latest"
		args: ["server", "start"]
		ports: [{name: "http", containerPort: 8888}]
		env: [{
			name:  "ATUIN_DB_URI"
			value: "postgres://$(POSTGRES_USERNAME):$(POSTGRES_PASSWORD)@postgres:5432/$(POSTGRES_DB)"
		}, {
			name:  "ATUIN_HOST"
			value: "0.0.0.0"
		}, {
			name:  "ATUIN_PORT"
			value: "8888"
		}, {
			name:  "ATUIN_OPEN_REGISTRATION"
			value: "true"
		}]
		envFrom: [{
			secretRef: name: "postgres-config"
		}]
		resources: {
			limits: {
				cpu:    "250m"
				memory: "1Gi"
			}
			requests: {
				cpu:    "250m"
				memory: "1Gi"
			}
		}
		volumeMounts: [{
			mountPath: "/config"
			name:      "config"
		}]
	}]
	volumes: [{
		name: "config"
		persistentVolumeClaim: claimName: "atuin-config"
	}]
}

k: Service: atuin: {}
k: Ingress: atuin: {}

k: PersistentVolumeClaim: "atuin-config": spec: {
	accessModes: ["ReadWriteOnce"]
	resources: requests: storage: "10Mi"
}
