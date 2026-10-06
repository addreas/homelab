package kube

let hostname = "ryot.addem.se"

k: OAuth2Client: "ryot": spec: {
	secretName:   "ryot-oauth2-client-credentials"
	redirectUris: ["https://\(hostname)/api/auth"]
}

k: Deployment: ryot: spec: template: spec: containers: [{
	name:  "ryot"
	image: "ghcr.io/ignisda/ryot:v10.5.0"
	securityContext: {
		runAsUser:  1001
		runAsGroup: 1001
		allowPrivilegeEscalation: true
		capabilities: add: ["NET_BIND_SERVICE"]
	}
	env: [{
		name: "DATABASE_URL"
		valueFrom: secretKeyRef: {
			name: "ryot-db-app"
			key:  "uri"
		}
	}, {
		name: "MOVIES_AND_SHOWS_TMDB_ACCESS_TOKEN"
		valueFrom: secretKeyRef: {
			name: "tmdb-api-key"
			key:  "access-token"
		}
	}, {
		name:  "SERVER_ADMIN_ACCESS_TOKEN"
		valueFrom: secretKeyRef: {
			name: "ryot"
			key:  "SERVER_ADMIN_ACCESS_TOKEN"
		}
	}, {
		name:  "SERVER_OIDC_ISSUER_URL"
		value: "https://auth.addem.se/"
	}, {
		name:  "FRONTEND_URL"
		value: "https://\(hostname)"
	}, {
		name: "SERVER_OIDC_CLIENT_ID"
		valueFrom: secretKeyRef: {
			name: "ryot-oauth2-client-credentials"
			key:  "CLIENT_ID"
		}
	}, {
		name: "SERVER_OIDC_CLIENT_SECRET"
		valueFrom: secretKeyRef: {
			name: "ryot-oauth2-client-credentials"
			key:  "CLIENT_SECRET"
		}
	}]
	ports: [{
		name:          "http"
		containerPort: 8000
	}]
	resources: {
		limits: {
			cpu:    "1"
			memory: "1Gi"
		}
		requests: {
			cpu:    "100m"
			memory: "256Mi"
		}
	}
}]

k: Service: ryot: {}

k: HTTPRoute: ryot: _authproxy: true

k: PostgresCluster: "ryot-db": spec: {
	instances: 2
	storage: size: "5Gi"
}
