package kube

import "encoding/json"

k: ConfigMap: "paperless-config": data: {
	"PAPERLESS_PORT":                    "8000"
	"PAPERLESS_REDIS":                   "redis://redis.paperless.svc:6379"
	"PAPERLESS_DBHOST":                  "postgres.paperless.svc"
	"PAPERLESS_TIKA_ENABLED":            "1"
	"PAPERLESS_TIKA_GOTENBERG_ENDPOINT": "http://gotenberg.paperless.svc:3000"
	"PAPERLESS_TIKA_ENDPOINT":           "http://tika.paperless.svc:9998"

	"PAPERLESS_URL": "https://paperless.addem.se"

	"PAPERLESS_APPS":                  "allauth.socialaccount.providers.openid_connect"
	"PAPERLESS_DISABLE_REGULAR_LOGIN": "true"

	"PAPERLESS_TIME_ZONE": "Europe/Stockholm"
	// "PAPERLESS_OCR_LANGUAGE":     "swe"
	// "PAPERLESS_OCR_LANGUAGES":    "swe eng"
	"PAPERLESS_CONSUMER_DISABLE": "true"
}

k: OAuth2Client: "paperless": spec: {
	clientName: "paperless"
	grantTypes: ["authorization_code", "refresh_token"]
	redirectUris: ["https://paperless.addem.se/accounts/oidc/lauset/login/callback/"]
	secretName:  "paperless-oauth2-client-credentials"
	scope:       "openid email profile"
	skipConsent: true
}

k: StatefulSet: "paperless": spec: {
	template: spec: {
		containers: [{
			name: "webserver"
			// image: "ghcr.io/paperless-ngx/paperless-ngx:\(githubReleases["paperless-ngx/paperless-ngx"])"
			image: "ghcr.io/addreas/paperless-ngx:v2.20.9" @renovate(githubReleases: "paperless-ngx/paperless-ngx")
			ports: [{
				name:          "http"
				containerPort: 8000
			}]
			envFrom: [{
				configMapRef: name: "paperless-config"
			}, {
				secretRef: name: "paperless-secrets"
			}, {
				secretRef: name: "postgres-config"
			}, {
				secretRef: name: "paperless-oauth2-client-credentials"
			}]
			env: [{
				name:  "PAPERLESS_DBNAME"
				value: "$(POSTGRES_DB)"
			}, {
				name:  "PAPERLESS_DBUSER"
				value: "$(POSTGRES_USER)"
			}, {
				name:  "PAPERLESS_DBPASS"
				value: "$(POSTGRES_PASSWORD)"
			}, {
				name: "PAPERLESS_SOCIALACCOUNT_PROVIDERS"
				value: json.Marshal({
					openid_connect: APPS: [{
						provider_id: "lauset"
						name:        "Lauset"
						client_id:   "$(CLIENT_ID)"
						secret:      "$(CLIENT_SECRET)"
						settings: {
							server_url:         "https://auth.addem.se/hydra/.well-known/openid-configuration"
							uid_field:          "email"
							oauth_pkce_enabled: true
						}
					}]
				})
			}, {
				name:  "S6_YES_I_WANT_A_WORLD_WRITABLE_RUN_BECAUSE_KUBERNETES"
				value: "1"
			}]
			volumeMounts: [{
				name:      "data"
				mountPath: "/usr/src/paperless/data"
				subPath:   "data"
			}, {
				name:      "data"
				mountPath: "/usr/src/paperless/media"
				subPath:   "media"
			}, {
				name:      "run"
				mountPath: "/run"
			}]
		}]
		volumes: [{
			name: "run"
			emptyDir: {}
		}]
	}
	volumeClaimTemplates: [{
		metadata: name: "data"
		spec: {
			accessModes: ["ReadWriteOnce"]
			resources: requests: storage: "5Gi"
		}
	}]
}

k: Service: "paperless": spec: {}

k: Service: "http-error": spec: ports: [{
	name: "null"
	port: 503
}]

k: Ingress: "paperless": spec: rules: [{
	host: "paperless.addem.se"
	http: {
		paths: [{
			backend: service: {
				name: "http-error"
				port: number: 503
			}
			path:     "/admin"
			pathType: "Prefix"
		}, {
			backend: service: {
				name: "paperless"
				port: number: 8000
			}
			path:     "/"
			pathType: "Prefix"
		}]
	}
}]
