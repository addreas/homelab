package kube

k: Deployment: "periserve": {
	spec: {
		replicas: 1
		template: {
			spec: {
				initContainers: [{
					name:            "migrations"
					image:           "ghcr.io/jonasdahl/periserve:\(periserveVersion)"
					imagePullPolicy: "Always"
					env: [{
						name:  "SESSION_SECRET"
						value: "ABCDEF1234567890"
					}, {
						name:  "DATABASE_URL"
						value: "postgresql://johndoe:randompasswordright@postgres:5432/mydb?schema=public"
					}]
					command: ["npm", "run", "prisma", "migrate", "deploy"]
				}]
				containers: [{
					name:  "periserve"
					image: "ghcr.io/jonasdahl/periserve:\(periserveVersion)"
					env: [{
						name:  "SESSION_SECRET"
						value: "ABCDEF1234567890"
					}, {
						name:  "DATABASE_URL"
						value: "postgresql://johndoe:randompasswordright@postgres:5432/mydb?schema=public"
					}, {
						name: "SENDGRID_API_KEY"
						value: "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"
					}]
					ports: [{containerPort: 3000}]
				}]
				imagePullSecrets: [{name: "periserve-ghcr"}]
			}
		}
	}
}
