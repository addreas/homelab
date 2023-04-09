package kube

k: Deployment: "packlistor": {
	spec: {
		template: {
			spec: {
				imagePullSecrets: [{name: "regcred"}]
				containers: [{
					name:  "packlistor"
					image: "ghcr.io/jonasdahl/packlistor.se:\(githubReleases."jonasdahl/packlistor.se")"
					ports: [{containerPort: 3000}]
					
					envFrom: [
						{secretRef: name: "packlistor-postgres-credentials"},
					]
					command: ["sh", "-c", "echo Database URL is $DATABASE_URL && pnpm run start"]
					env: [{
						name:  "DATABASE_URL"
						value: "postgres://$(POSTGRES_USER):$(POSTGRES_PASSWORD)@packlistordb:5432/packlistor"
					}, {
						name:  "SESSION_SECRET"
						value: "c70f69d6-8843-4441-80fb-5da374469ea4" // TODO
					}]
				}]
			}
		}
	}
}
