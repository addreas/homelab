package kube

k: Deployment: "trippler": {
	spec: {
		template: {
			spec: {
				imagePullSecrets: [{name: "regcred"}]
				initContainers: [{
					name:  "migrations"
					image: "ghcr.io/jonasdahl/trippler.se:\(otherTags."jonasdahl/trippler.se")"
					envFrom: [{secretRef: name: "trippler-postgres-credentials"}]
					env: [{
						name:  "DATABASE_URL"
						value: "postgresql://$(POSTGRES_USER):$(POSTGRES_PASSWORD)@trippler-db:5432/trippler"
					}]
					command: ["pnpm", "run", "prisma", "migrate", "deploy"]
				}]
				containers: [{
					name:  "trippler"
					image: "ghcr.io/jonasdahl/trippler.se:\(otherTags."jonasdahl/trippler.se")"
					ports: [{containerPort: 3000}]

					envFrom: [
						{secretRef: name: "trippler-postgres-credentials"},
					]
					command: ["sh", "-c", "echo Database URL is $DATABASE_URL && pnpm run start"]
					env: [{
						name:  "DATABASE_URL"
						value: "postgresql://$(POSTGRES_USER):$(POSTGRES_PASSWORD)@trippler-db:5432/trippler"
					}, {
						name:  "SESSION_SECRET"
						value: "c70f69d6-8843-4441-80fb-5da374469ea4" // TODO
					}]
				}]
			}
		}
	}
}
