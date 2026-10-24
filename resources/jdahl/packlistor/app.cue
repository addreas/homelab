package kube

let hostNames = ["packlistor.se", "www.packlistor.se"]

k: HTTPRoute: packlistor: {
	spec: hostnames: hostNames
}

k: Service: packlistor: {}

let baseContainer = {
	image:           "ghcr.io/jonasdahl/packlistor.se:main"
	imagePullPolicy: "Always"
	envFrom: [{secretRef: name: "packlistor-secrets"}]
	env: [{
		name: "DATABASE_URL"
		valueFrom: secretKeyRef: {
			name: "\(postgresHost)-app"
			key:  "uri"
		}
	}]
}

k: Deployment: "packlistor": {
	metadata: labels: "homelab.addem.se/autodeploy": "true"
	spec: {
		replicas: 0
		template: {
			spec: {
				imagePullSecrets: [{name: "regcred"}]
				initContainers: [baseContainer & {
					name: "migrations"
					command: ["pnpm", "run", "prisma", "migrate", "deploy"]
				}]
				containers: [baseContainer & {
					name: "packlistor"
					ports: [{containerPort: 3000, name: "http"}]
				}]
			}
		}
	}
}
