package kube

k: HTTPRoute: svalaapp: {
	spec: {
		hostnames: ["svalaapp.se", "svalaapp.com"]
		rules: [{
			backendRefs: [{
				name: "prototyp"
				port: k.Service.prototyp.spec.ports[0].port
			}]
		}]
	}
}

k: Service: prototyp: {}

let baseContainer = {
	image:           "ghcr.io/jonasdahl/svalaapp.com:main"
	imagePullPolicy: "Always"
	ports: [{containerPort: 3000, name: "http"}]
	envFrom: [
		{secretRef: name: "positionstack"},
		{secretRef: name: "meteostat"},
		{secretRef: name: "google"},
		{secretRef: name: "openai"},
		{secretRef: name: "pexels"},
		{secretRef: name: "github"},
		{secretRef: name: "nextauth"},
		{secretRef: name: "trippler-secrets"},
		{secretRef: name: "google-oauth"},
		{secretRef: name: "sendgrid"},
		{secretRef: name: "vapid"},
	]
	env: [{
		name: "DATABASE_URL"
		valueFrom: secretKeyRef: {
			name: "prototyp-postgres-app"
			key:  "uri"
		}
	}, {
		name:  "REDIS_URL"
		value: "redis://prototyp-redis:6379"
	}, {
		name:  "PERSIST_EMAILS"
		value: "redis://prototyp-redis:6379"
	}, {
		name:  "PERSIST_EMAILS_DIRECTORY"
		value: "/emails"
	}, {
		name:  "LOG_LEVEL"
		value: "info"
	}, ...]
}

k: Deployment: "prototyp": {
	spec: {
		replicas: 0
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
					volumeMounts: [{mountPath: "/emails", name: "emails"}]
				}]
				volumes: [{name: "emails", emptyDir: sizeLimit: "500Mi"}]
			}
		}
	}
}

k: PostgresCluster: "prototyp-postgres": spec: {
	instances: 2
	storage: size: "1Gi"
	bootstrap: initdb: {
		owner:    "trippler"
		database: "trippler"
	}
}

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
