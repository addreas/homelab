package kube

k: Ingress: logger: {}

k: Service: logger: {}

let baseContainer = {
	image: "ghcr.io/jonasdahl/logger:main"
	imagePullPolicy: "Always"
	envFrom: [{secretRef: name: "postgres-secrets"}, {secretRef: name: "app-secrets"}]
	env: [{
		name:  "DATABASE_URL"
		value: "postgres://$(POSTGRES_USER):$(POSTGRES_PASSWORD)@logger-db:5432/$(POSTGRES_DB)"
	}]
}

k: Deployment: "logger": {
	spec: {
		template: {
			spec: {
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
	}
}