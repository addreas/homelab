package kube

let hostNames = ["packlistor.se", "www.packlistor.se"]

k: Ingress: packlistor: {
	spec: {
		rules: [ for h in hostNames {
			host: h
			http: paths: [{
				path:     "/"
				pathType: "Prefix"
				backend: service: {
					name: "packlistor"
					port: name: "http"
				}
			}]
		}]
	}
}

k: Service: packlistor: {}

let baseContainer = {
	image: "ghcr.io/jonasdahl/packlistor.se:main"
	envFrom: [{secretRef: name: "packlistor-secrets"}]
	env: [{
		name:  "DATABASE_URL"
		value: "postgresql://$(POSTGRES_USER):$(POSTGRES_PASSWORD)@\(postgresHost):5432/$(POSTGRES_DB)"
	}]
}

k: Deployment: "packlistor": {
	spec: {
		template: {
			spec: {
				imagePullSecrets: [{name: "regcred"}]
				initContainers: [baseContainer & {
					name: "migrations"
					command: ["pnpm", "run", "prisma", "migrate", "deploy"]
				}]
				containers: [baseContainer & {
					name: "packlistor"
					ports: [{containerPort: 3000, name:"http"}]
				}]
			}
		}
	}
}
