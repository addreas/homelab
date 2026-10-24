package kube

k: HTTPRoute: logger: {}
k: HTTPRoute: loggerjdahl: {
	spec: hostnames: ["log.jdahl.se"]
	_defaultBackendRef: {
		name: "logger"
		port: k.Service["logger"].spec.ports[0].port
	}
}

k: Service: logger: {}

let baseContainer = {
	image:           "ghcr.io/jonasdahl/logger:main"
	imagePullPolicy: "Always"
	envFrom: [{secretRef: name: "postgres-secrets"}, {secretRef: name: "app-secrets"}, {secretRef: name: "push-secrets"}]
	env: [{
		name: "DATABASE_URL"
		valueFrom: secretKeyRef: {
			name: "logger-db-app"
			key:  "uri"
		}
	}]
}

k: Deployment: "logger": spec: {
	replicas: 0
	template: spec: {
		initContainers: [baseContainer & {
			name: "migrations"
			command: ["pnpm", "run", "prisma", "migrate", "deploy"]
		}]
		containers: [baseContainer & {
			name: "logger"
			ports: [{containerPort: 3000, name: "http"}]
		}]
	}
}
