package kube

k: Deployment: "logger": {
	spec: {
		template: {
			spec: {
				initContainers: [{
					name: "migrations"
					image: "ghcr.io/jonasdahl/logger:\(githubReleases."jonasdahl/logger")"
					envFrom: [{secretRef: name: "logger-postgres-credentials"}]
					env: [{
						name:  "DATABASE_URL"
						value: "postgres://$(POSTGRES_USER):$(POSTGRES_PASSWORD)@logger-db:5432/logger"
					}]
					command: ["pnpm", "run", "prisma", "migrate", "deploy"]
				}]
				containers: [{
					name:  "logger"
					image: "ghcr.io/jonasdahl/logger:\(githubReleases."jonasdahl/logger")"
					envFrom: [
						{secretRef: name: "logger-postgres-credentials"},
					]
					env: [{
						name:  "DATABASE_URL"
						value: "postgres://$(POSTGRES_USER):$(POSTGRES_PASSWORD)@logger-db:5432/logger"
					}, {
						name:  "APP_SECRET"
						value: "c70f69d6-8843-4441-80fb-5da374469ea4" // TODO
					}, {
						name: "POLAR_CLIENT_ID"
						valueFrom: secretKeyRef: {
							name: "polar-client"
							key:  "POLAR_CLIENT_ID"
						}
					}, {
						name: "POLAR_CLIENT_SECRET"
						valueFrom: secretKeyRef: {
							name: "polar-client"
							key:  "POLAR_CLIENT_SECRET"
						}
					}]
					ports: [{containerPort: 3000}]
				}]
			}
		}
	}
}

k: Ingress: logger: {}

k: Service: logger: spec: ports: [{
	name: "http"
}]
