package kube

k: Deployment: bitmagnet: spec: template: {
	metadata: labels: "vpn-egress": "client"
	spec: containers: [{
		name:  "bitmagnet"
		image: "ghcr.io/bitmagnet-io/bitmagnet:v0.10.0"
		command: ["bitmagnet", "worker", "run", "--all"]
		env: [{
			name: "POSTGRES_DSN"
			valueFrom: secretKeyRef: {
				name: "bitmagnet-db-app"
				key:  "uri"
			}
		}, {
			name: "TMDB_API_KEY"
			valueFrom: secretKeyRef: {
				name: "tmdb-api-key"
				key:  "api-key"
			}

		}]
		ports: [{
			name:          "http"
			containerPort: 3333
		}]
		resources: {
			limits: {
				cpu:    "1"
				memory: "2Gi"
			}
			requests: {
				cpu:    "250m"
				memory: "512Mi"
			}
		}
	}]
}

k: Service: bitmagnet: {}

k: HTTPRoute: bitmagnet: _authproxy: true

k: PostgresCluster: "bitmagnet-db": spec: {
	instances: 2
	storage: size: "5Gi"
}
