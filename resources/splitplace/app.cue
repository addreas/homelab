package kube

let hostNames = ["splitplace.jdahl.se"]

k: Ingress: splitplace: {
	spec: {
		rules: [ for h in hostNames {
			host: h
			http: paths: [{
				path:     "/"
				pathType: "Prefix"
				backend: service: {
					name: "splitplace"
					port: name: "http"
				}
			}]
		}]
	}
}

k: Service: splitplace: {}

let baseContainer = {
	image:           "ghcr.io/jonasdahl/bill-splitting:main"
	imagePullPolicy: "Always"
	envFrom: [
		{secretRef: name: "splitplace-postgres-secrets"},
		{secretRef: name: "splitplace-app-secrets"},
		{secretRef: name: "splitplace-github-oauth-secrets"},
		{secretRef: name: "splitplace-google-oauth-secrets"}
	]
	env: [{
		name:  "DATABASE_URL"
		value: "postgresql://$(POSTGRES_USER):$(POSTGRES_PASSWORD)@\(postgresHost):5432/$(POSTGRES_DB)"
	}, {
		name:  "APP_URL"
		value: "https://\(hostNames[0])"
	}]
}

k: Deployment: "splitplace": {
	metadata: labels: "homelab.addem.se/autodeploy": "true"
	spec: {
		replicas: 1
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
