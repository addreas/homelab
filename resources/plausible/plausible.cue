package kube

k: Ingress: plausible: {}

k: Service: plausible: spec: ports: [{name: "plausible"}]

k: Deployment: plausible: spec: template: spec: {
	securityContext: {
		runAsUser:  1000
		runAsGroup: 1000
	}
	initContainers: [{
		name:  "plausible-init"
		image: "plausible/analytics:latest"
		command: ["/bin/sh", "-c"]
		args: ["sleep 30 && /entrypoint.sh db createdb && /entrypoint.sh db migrate && /entrypoint.sh db init-admin"]
		envFrom: [
			{secretRef: name: "plausible-config"},
			{secretRef: name: "postgres-credentials-plausible"},
			{secretRef: name: "plausible-events-db-user"},
		]
		env: [{
			name:  "DATABASE_URL"
			value: "postgres://$(POSTGRES_USER):$(POSTGRES_PASSWORD)@plausible-db:5432/plausible"
		}, {
			name:  "CLICKHOUSE_DATABASE_URL"
			value: "http://$(CLICKHOUSE_USER):$(CLICKHOUSE_PASSWORD)@plausible-events-db:8123/plausible"
		}, {
			name:  "SMTP_HOST_ADDR"
			value: "plausible-smtp"
		},
		]
		securityContext: allowPrivilegeEscalation: false
	}]
	containers: [{
		image: "plausible/analytics:latest"
		ports: [{containerPort: 8000}]
		envFrom: [
			{secretRef: name: "plausible-config"},
			{secretRef: name: "postgres-credentials-plausible"},
			{secretRef: name: "plausible-events-db-user"},
		]
		env: [{
			name:  "DATABASE_URL"
			value: "postgres://$(POSTGRES_USER):$(POSTGRES_PASSWORD)@plausible-db:5432/plausible"
		}, {
			name:  "CLICKHOUSE_DATABASE_URL"
			value: "http://$(CLICKHOUSE_USER):$(CLICKHOUSE_PASSWORD)@plausible-events-db:8123/plausible"
		}, {
			name:  "SMTP_HOST_ADDR"
			value: "plausible-smtp"
		},
		]
		readinessProbe: {
			httpGet: {
				path: "/api/health"
				port: 8000
			}
			initialDelaySeconds: 35
			failureThreshold:    6
			periodSeconds:       10
		}
		livenessProbe: {
			httpGet: {
				path: "/api/health"
				port: 8000
			}
			initialDelaySeconds: 45
			failureThreshold:    3
			periodSeconds:       10
		}
	}]
}
