package kube

let hostNames = ["trippler.se", "www.trippler.se", "trip.jdahl.se"]

k: Ingress: trippler: {
	spec: {
		rules: [ for h in hostNames {
			host: h
			http: paths: [{
				path:     "/"
				pathType: "Prefix"
				backend: service: {
					name: "trippler"
					port: name: "http"
				}
			}]
		}]
	}
}

k: Service: trippler: {}

let baseContainer = {
	image: "ghcr.io/jonasdahl/trippler.se:main"
	imagePullPolicy: "Always"
	envFrom: [{secretRef: name: "trippler-secrets"}]
	env: [{
		name:  "DATABASE_URL"
		value: "postgresql://$(POSTGRES_USER):$(POSTGRES_PASSWORD)@\(postgresHost):5432/$(POSTGRES_DB)"
	}]
}

k: Deployment: "trippler": {
	metadata: labels: "homelab.addem.se/autodeploy": "true"
	spec: {
		replicas: 2
		template: {
			spec: {
				imagePullSecrets: [{name: "regcred"}]
				initContainers: [baseContainer & {
					name:  "migrations"
					command: ["pnpm", "run", "prisma", "migrate", "deploy"]
				}]
				containers: [baseContainer & {
					name:  "trippler"
					ports: [{containerPort: 3000, name:"http"}]
				}]
			}
		}
	}
}
