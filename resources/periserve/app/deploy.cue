package kube

k: Deployment: "periserve": {
	spec: {
		replicas: 1
		template: {
			spec: {
				initContainers: [{
					name:            "migrations"
					image:           "ghcr.io/periserve/periserve:\(periserveVersion)"
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
					image: "ghcr.io/periserve/periserve:\(periserveVersion)"
					env: [{
						name:  "SESSION_SECRET"
						value: "ABCDEF1234567890"
					}, {
						name:  "DATABASE_URL"
						value: "postgresql://johndoe:randompasswordright@postgres:5432/mydb?schema=public"
					}]
					envFrom: [{secretRef: name: "sendgrid"}]
					ports: [{containerPort: 3000}, {containerPort: 4000}]
					livenessProbe: {
						periodSeconds:       120
						httpGet: {
							path: "/"
							port: 3000
						}
					}
					startupProbe: {
						initialDelaySeconds: 10
						periodSeconds:       5
						httpGet: {
							path: "/"
							port: 3000
						}
					}
				}]
				imagePullSecrets: [{name: "periserve-ghcr"}]
			}
		}
	}
}
