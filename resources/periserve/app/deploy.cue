package kube

k: Deployment: "periserve": {
	metadata: annotations: {
		"version": "a5859b5c-416b-4f5e-9f0b-8ef550e0fbac"
	}
	spec: {
		replicas: 1
		template: {
			spec: {
				initContainers: [{
					name:  "migrate"
					image: "ghcr.io/jonasdahl/periserve:main"
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
					image: "ghcr.io/jonasdahl/periserve:main"
					env: [{
						name:  "SESSION_SECRET"
						value: "ABCDEF1234567890"
					}, {
						name:  "DATABASE_URL"
						value: "postgresql://johndoe:randompasswordright@postgres:5432/mydb?schema=public"
					}]
					ports: [{containerPort: 3000}]
				}]
                imagePullSecrets: [{name: "periserve-ghcr"}]
			}
		}
	}
}
