package kube

import (
	"encoding/json"
	"encoding/yaml"
)

_kratos_config: #KratosConfigSchema & {
	serve: {
		public: {
			base_url: "https://\(_hostname)/kratos"
			cors: enabled:                   false
			request_log: disable_for_health: true
		}
		admin: base_url: "http://kratos:4434/"
	}

	selfservice: {
		default_browser_return_url: "https://\(_hostname)/"
		allowed_return_urls: [
			"https://\(_hostname)/",
			"https://\(_hostname)/hydra/login",
		]

		methods: {
			password: enabled: true
			totp: {
				enabled: true
				config: issuer: "Lauset"
			}
			lookup_secret: enabled: true
			webauthn: {
				enabled: true
				config: {
					passwordless: true
					rp: {
						display_name: "Lauset"
						id:           "addem.se"
						origin:       "https://auth.addem.se"
					}
				}
			}
			passkey: {
				enabled: true
				config: rp: webauthn.config.rp
			}
		}

		flows: {
			error: ui_url: "https://\(_hostname)/error"

			settings: {
				ui_url:                     "https://\(_hostname)/settings"
				privileged_session_max_age: "15m"
			}

			recovery: {
				enabled: true
				ui_url:  "https://\(_hostname)/recovery"
			}

			verification: {
				enabled: true
				ui_url:  "https://\(_hostname)/settings/verification"
				after: default_browser_return_url: "https://\(_hostname)/"
			}

			logout: after: default_browser_return_url: "https://\(_hostname)/"

			login: {
				ui_url:   "https://\(_hostname)/login"
				lifespan: "10m"
			}

			registration: {
				lifespan: "10m"
				ui_url:   "https://\(_hostname)/registration"
				after: {
					password: hooks: [{hook: "session"}, {hook: "show_verification_ui"}]
					webauthn: hooks: [{hook: "session"}]
					// passkey: hooks: [{hook: "session"}]
				}
			}
		}
	}

	oauth2_provider: url: "https://\(_hostname)/hydra/"

	log: {
		level:                 "info"
		format:                "text"
		leak_sensitive_values: false
	}

	ciphers: algorithm: "xchacha20-poly1305"

	hashers: {
		algorithm: "bcrypt"
		bcrypt: {}
	}

	identity: {
		default_schema_id: "default"
		schemas: [{
			id:  "default"
			url: "file:///etc/config/identity.schema.json"
		}]
	}
}

let identity_schema = {
	"$id":     "https://\(_hostname)/person.schema.json"
	"$schema": "http://json-schema.org/draft-07/schema#"
	"title":   "Person"
	"type":    "object"
	"properties": {
		"traits": {
			"type": "object"
			"properties": {
				"email": {
					"type":      "string"
					"format":    "email"
					"title":     "E-Mail"
					"minLength": 3
					"ory.sh/kratos": {
						"credentials": {
							"password": "identifier":  true
							"totp": "account_name":    true
							"webauthn": "identifier":  true
							"passkey": "display_name": true
							"code": {
								"identifier": true
								"via":        "email"
							}
						}
						"recovery": "via":     "email"
						"verification": "via": "email"
					}
				}
				"name": {
					"type": "object"
					"properties": {
						"first": {
							"title": "First Name"
							"type":  "string"
						}
						"last": {
							"title": "Last Name"
							"type":  "string"
						}
					}
				}
				"username": {
					"title": "Username"
					"type":  "string"
				}
			}
			"additionalProperties": false
		}
	}
}

k: ConfigMap: "kratos-config": data: {
	"kratos.yaml":          yaml.Marshal(_kratos_config)
	"identity.schema.json": json.Marshal(identity_schema)
}

k: Deployment: kratos: spec: template: spec: {
	initContainers: [{
		name:  "migrate"
		image: "oryd/kratos:\(githubReleases["ory/kratos"])"
		command: ["kratos"]
		args: [
			"migrate",
			"sql",
			"-e",
			"-y",
		]
		envFrom: [{secretRef: name: "kratos"}]
	}]
	containers: [_probes & {
		image: "oryd/kratos:\(githubReleases["ory/kratos"])"
		command: ["kratos"]
		args: [
			"serve",
			"all",
			"--config",
			"/etc/config/kratos.yaml",
		]
		ports: [{
			name:          "http-admin"
			containerPort: 4434
		}, {
			name:          "http-public"
			containerPort: 4433
		}]
		envFrom: [{secretRef: name: "kratos"}]
		env: [{
			name: "DSN"
			valueFrom: secretKeyRef: {
				name: "kratos-db-app"
				key:  "uri"
			}
		}]
		volumeMounts: [{
			name:      "kratos-config-volume"
			mountPath: "/etc/config"
			readOnly:  true
		}]
	}]
	volumes: [{
		name: "kratos-config-volume"
		configMap: name: "kratos-config"
	}]
}

k: Service: "kratos-admin": spec: {
	selector: app: "kratos"
	ports: [{
		port:       80
		targetPort: "http-admin"
		name:       "http"
	}]
}

k: Service: "kratos-public": spec: {
	selector: app: "kratos"
	ports: [{
		port:       80
		targetPort: "http-public"
		name:       "http"
	}]
}

k: PostgresCluster: "kratos-db": spec: {
	instances: 1
	storage: size: "1Gi"
}
