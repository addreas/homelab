package kube

let dockerImage = "ghcr.io/jonasdahl/trippler.se:\(otherTags."jonasdahl/trippler.se")"

k: Deployment: "trippler": {
	spec: {
		template: {
			spec: {
				imagePullSecrets: [{name: "regcred"}]
				initContainers: [{
					name:  "migrations"
					image: dockerImage
					envFrom: [
						{secretRef: name: "trippler-secrets"},
						{configMapRef: name: "trippler-env"},
					]
					env: [{
						name:  "DATABASE_URL"
						value: "postgresql://$(POSTGRES_USER):$(POSTGRES_PASSWORD)@trippler-db:5432/$(POSTGRES_DB)"
					}]
					command: ["pnpm", "run", "prisma", "migrate", "deploy"]
				}]
				containers: [{
					name:  "trippler"
					image: dockerImage
					ports: [{containerPort: 3000}]
					envFrom: [
						{secretRef: name: "trippler-secrets"},
						{configMapRef: name: "trippler-env"},
					]
					env: [{
						name:  "DATABASE_URL"
						value: "postgresql://$(POSTGRES_USER):$(POSTGRES_PASSWORD)@trippler-db:5432/$(POSTGRES_DB)"
					}]
				}]
			}
		}
	}
}
