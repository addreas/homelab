package kube

k: Ingress: logger: {}
k: Ingress: logger: {
	spec: {
		rules: [{
			host: "log.jdahl.se"
			http: paths: [{
				path:     "/"
				pathType: "Prefix"
				backend: service: {
					name: "logger"
					port: *close({
						number: k.Service["logger"].spec.ports[0].port
					}) | close({
						name: k.Service["logger"].spec.ports[0].name
					})
				}
			}]
		}]
	}
}

k: Service: logger: {}

let baseContainer = {
	image:           "ghcr.io/jonasdahl/logger:main"
	imagePullPolicy: "Always"
	envFrom: [{secretRef: name: "postgres-secrets"}, {secretRef: name: "app-secrets"}]
	env: [{
		name:  "DATABASE_URL"
		value: "postgres://$(POSTGRES_USER):$(POSTGRES_PASSWORD)@logger-db:5432/$(POSTGRES_DB)"
	}]
}

k: Deployment: "logger": {
	metadata: labels: "homelab.addem.se/autodeploy": "true"
	spec: {
		template: {
			spec: {
				initContainers: [baseContainer & {
					name: "migrations"
					command: ["pnpm", "run", "prisma", "migrate", "deploy"]
				}]
				containers: [baseContainer & {
					name: "logger"
					ports: [{containerPort: 3000, name: "http"}]
				}]
			}
		}
	}
}
