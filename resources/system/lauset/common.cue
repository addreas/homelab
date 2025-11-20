package kube

_hostname: "auth.addem.se"

k: Ingress: "ory": {
	metadata: annotations: "ingress.kubernetes.io/rewrite-target": "/"
	spec: {
		tls: [{
			hosts: [_hostname]
			secretName: "ory-cert"
		}]
		rules: [{
			host: _hostname
			http: paths: [{
				path: "/kratos"
				backend: service: {
					name: "kratos-public"
					port: name: "http"
				}
			}, {
				path:     "/hydra"
				pathType: "Prefix"
				backend: service: {
					name: "hydra-public"
					port: name: "http"
				}
			}]
		}]
	}
}

k: Ingress: "lauset": {
	spec: {
		tls: [{
			hosts: [_hostname]
			secretName: "ory-cert"
		}]
		rules: [{
			host: _hostname
			http: paths: [{}, {
				path:     "/hydra/consent"
				pathType: "Exact"
				backend: service: {
					name: "lauset"
					port: name: "http"
				}
			}, {
				path:     "/hydra/login"
				pathType: "Exact"
				backend: service: {
					name: "lauset"
					port: name: "http"
				}
			}]
		}]
	}
}

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
				after: password: hooks: [{hook: "session"}]
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
			url: "file:///etc/config/person.schema.json"
		}]
	}
}

_person_schema: {
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
							"password": "identifier": true
							"totp": "account_name":   true
						}
						"recovery": "via":     "email"
						"verification": "via": "email"
					}
				}
			}
			"additionalProperties": false
		}
	}
}

_hydra_config: #HydraConfigSchema & {
	serve: {
		admin: port: 4445
		public: {
			port: 4444
			request_log: disable_for_health: true
		}
		tls: allow_termination_from: ["10.0.0.0/8"]
	}
	urls: {
		self: issuer: "https://\(_hostname)/hydra/"
		self: public: "https://\(_hostname)/hydra/"
		self: admin:  "http://hydra-admin.ory.svc.cluster.local"
		consent: "https://\(_hostname)/hydra/consent"
		login:   "https://\(_hostname)/hydra/login"
		logout:  "https://\(_hostname)/logout"
	}
}
