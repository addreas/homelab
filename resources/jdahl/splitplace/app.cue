package kube

let hostNames = ["splitplace.app", "splitplace.jdahl.se"]

k: HTTPRoute: splitplace: {
	spec: hostnames: hostNames
}

k: Service: splitplace: {}

let baseContainer = {
	image:           "ghcr.io/jonasdahl/bill-splitting:main"
	imagePullPolicy: "Always"
	envFrom: [
		{secretRef: name: "splitplace-postgres-secrets"},
		{secretRef: name: "splitplace-app-secrets"},
		{secretRef: name: "auth0"},
		{secretRef: name: "sendgrid"},
	]
	env: [{
		name: "DATABASE_URL"
		valueFrom: secretKeyRef: {
			name: "\(postgresHost)-app"
			key:  "uri"
		}
	}, {
		name:  "APP_URL"
		value: "https://\(hostNames[0])"
	}]
}

k: Deployment: "splitplace": {
	metadata: labels: "homelab.addem.se/autodeploy": "true"
	spec: {
		replicas: 0
		template: {
			spec: {
				imagePullSecrets: [{name: "regcred"}]
				initContainers: [baseContainer & {
					name: "migrations"
					command: ["npm", "run", "prisma", "migrate", "deploy"]
				}]
				containers: [baseContainer & {
					name: "splitplace"
					ports: [{containerPort: 3000, name: "http"}]
				}]
			}
		}
	}
}
