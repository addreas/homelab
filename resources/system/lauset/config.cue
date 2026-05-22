package kube

import (
	"encoding/json"
	"encoding/yaml"
)

let hostname = "auth.addem.se"

let kratos_config = #KratosConfigSchema & {
	serve: {
		public: {
			base_url: "https://\(hostname)/kratos"
			cors: enabled:                   false
			request_log: disable_for_health: true
		}
		admin: base_url: "http://kratos:4434/"
	}

	selfservice: {
		default_browser_return_url: "https://\(hostname)/"
		allowed_return_urls: [
			"https://\(hostname)/",
			"https://\(hostname)/hydra/login",
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
						origin:       "https://\(hostname)"
					}
				}
			}
			passkey: {
				enabled: true
				config: rp: webauthn.config.rp
			}
		}

		flows: {
			error: ui_url: "https://\(hostname)/error"

			settings: {
				ui_url:                     "https://\(hostname)/settings"
				privileged_session_max_age: "15m"
			}

			recovery: {
				enabled: true
				ui_url:  "https://\(hostname)/recovery"
			}

			verification: {
				enabled: true
				ui_url:  "https://\(hostname)/settings/verification"
				after: default_browser_return_url: "https://\(hostname)/"
			}

			logout: after: default_browser_return_url: "https://\(hostname)/"

			login: {
				ui_url:   "https://\(hostname)/login"
				lifespan: "10m"
			}

			registration: {
				lifespan: "10m"
				ui_url:   "https://\(hostname)/registration"
				after: {
					password: hooks: [{hook: "session"}, {hook: "show_verification_ui"}]
					webauthn: hooks: [{hook: "session"}]
					// passkey: hooks: [{hook: "session"}]
				}
			}
		}
	}

	oauth2_provider: url: "https://\(hostname)/hydra/"

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
	"$id":     "https://\(hostname)/person.schema.json"
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

let hydra_config = #HydraConfigSchema & {
	serve: {
		admin: port: 4445
		public: {
			port: 4444
			request_log: disable_for_health: true
		}
		tls: allow_termination_from: ["10.0.0.0/8"]
	}
	urls: {
		self: issuer: "https://\(hostname)/hydra/"
		self: public: "https://\(hostname)/hydra/"
		self: admin:  "http://hydra-admin.ory.svc.cluster.local"
		consent: "https://\(hostname)/hydra/consent"
		login:   "https://\(hostname)/hydra/login"
		logout:  "https://\(hostname)/logout"
	}
}

k: ConfigMap: "kratos-config": data: {
	"kratos.yaml":          yaml.Marshal(kratos_config)
	"identity.schema.json": json.Marshal(identity_schema)
}

k: ConfigMap: "hydra": data: "config.yaml": yaml.Marshal(hydra_config)

k: ConfigMap: "lauset": data: {
	KRATOS_BROWSER_URL: "https://\(hostname)/kratos"
	KRATOS_ADMIN_URL:   "http://kratos-admin.ory.svc.cluster.local"
	KRATOS_PUBLIC_URL:  "http://kratos-public.ory.svc.cluster.local"
	HYDRA_ADMIN_URL:    "http://hydra-admin.ory.svc.cluster.local"
}
