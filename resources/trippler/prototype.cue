package kube

k: Ingress: prototyp: {
	spec: {
		rules: [{
			host: "prototyp.jdahl.se"
			http: paths: [{
				path:     "/"
				pathType: "Prefix"
				backend: service: {
					name: "prototyp"
					port: name: "http"
				}
			}]
		}]
	}
}

k: Service: prototyp: {}

let baseContainer = {
	image:           "ghcr.io/jonasdahl/prototype:main"
	imagePullPolicy: "Always"
	ports: [{containerPort: 3000, name: "http"}]
	envFrom: [
		{secretRef: name: "positionstack"},
		{secretRef: name: "meteostat"},
		{secretRef: name: "google"},
		{secretRef: name: "openai"},
		{secretRef: name: "pexels"},
		{secretRef: name: "github"},
		{secretRef: name: "trippler-secrets"},
	]
	env: [{
		name:  "DATABASE_URL"
		value: "postgresql://$(POSTGRES_USER):$(POSTGRES_PASSWORD)@prototyp-postgres:5432/$(POSTGRES_DB)"
	}, {
		name:  "REDIS_URL"
		value: "redis://prototyp-redis:6379"
	}]
}

k: Deployment: "prototyp": {
	spec: {
		replicas: 1
		template: {
			spec: {
				imagePullSecrets: [{name: "regcred"}]
				initContainers: [baseContainer & {
					name: "migrations"
					command: ["npx", "-y", "prisma", "migrate", "deploy"]
				}]
				containers: [baseContainer & {
					name: "prototype"
					ports: [{containerPort: 3000, name: "http"}]
				}]
			}
		}
	}
}

k: StatefulSet: "prototyp-postgres": spec: {
	template: spec: {
		securityContext: fsGroupChangePolicy: "Always"
		containers: [{
			name:  "postgres"
			image: "postgres:14"
			envFrom: [{secretRef: name: "trippler-secrets"}]
			ports: [{containerPort: 5432}]
			volumeMounts: [{
				name:      "data"
				mountPath: "/var/lib/postgresql"
				subPath:   "data"
			}]
			readinessProbe: {
				exec: command: ["/bin/sh", "-c", "pg_isready -U postgres"]
				initialDelaySeconds: 20
				failureThreshold:    6
				periodSeconds:       10
			}
			livenessProbe: {
				exec: command: ["/bin/sh", "-c", "pg_isready -U postgres"]
				initialDelaySeconds: 30
				failureThreshold:    3
				periodSeconds:       10
			}
		}]
	}
	volumeClaimTemplates: [{
		metadata: name: "data"
		spec: {
			accessModes: ["ReadWriteOnce"]
			resources: requests: storage: "1Gi"
		}
	}]
}

k: Service: "prototyp-postgres": spec: ports: [{
	name: "prototyp-postgres"
}]

k: StatefulSet: "prototyp-redis": spec: {
	template: spec: {
		containers: [{
			name:  "redis"
			image: "redis:6.2-alpine"
			ports: [{containerPort: 6379}]
			env: [{name: "ALLOW_EMPTY_PASSWORD", value: "yes"}]
			volumeMounts: [{
				name:      "data"
				mountPath: "/data"
			}]
		}]
	}
	volumeClaimTemplates: [{
		metadata: name: "data"
		spec: {
			accessModes: ["ReadWriteOnce"]
			resources: requests: storage: "1Gi"
		}
	}]
}

k: Service: "prototyp-redis": spec: ports: [{
	name: "prototyp-redis"
}]

_DeploymentRestarter & {
	_name:          "prototyp"
	_labelSelector: "app=prototyp"
}
