package kube

k: Deployment: "logger": {
	spec: {
		template: {
			spec: {
				containers: [{
					name:  "logger"
					image: "ghcr.io/jonasdahl/logger:\(githubReleases."jonasdahl/logger")"
					env: [{
						name:  "APP_SECRET"
						value: "c70f69d6-8843-4441-80fb-5da374469ea4" // TODO
					}, {
						name:  "POLAR_CLIENT_ID"
						value: "c70f69d6-8843-4441-80fb-5da374469ea4" // TODO
					}, {
						name:  "POLAR_CLIENT_SECRET"
						value: "c70f69d6-8843-4441-80fb-5da374469ea4" // TODO
					}, {
						name:  "DATABASE_URL"
						value: "postgres://postgres:postgres@postgres:5432/postgres" // TODO
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
