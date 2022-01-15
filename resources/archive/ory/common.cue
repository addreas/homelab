package kube

_hostname: "ory.addem.se"

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
				path:     "/api"
				pathType: "Prefix"
				backend: service: {
					name: "kratos-public"
					port: name: "http"
				}
			}, {
				path:     "/hydra"
				pathType: "Prefix"
				backend: service: {
					name: "hydra-login-consent-node"
					port: name: "http"
				}
			}, {
				path:     "/"
				pathType: "Prefix"
				backend: service: {
					name: "kratos-selfservice-ui-node"
					port: name: "http"
				}
			}]
		}]
	}
}

_kratos_config: {
	serve: {
		public: {
			base_url: "https://\(_hostname)/api"
			cors: enabled: false
		}
		admin: base_url: "http://kratos:4434/"
	}

	selfservice: {
		default_browser_return_url: "https://\(_hostname)/"
		whitelisted_return_urls: [
			"https://\(_hostname)/",
			"https://\(_hostname)/hydra/login",
		]

		methods: password: enabled: true

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
				ui_url:  "https://\(_hostname)/verification"
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

	log: {
		level:                 "debug"
		format:                "text"
		leak_sensitive_values: true
	}

	ciphers: algorithm: "xchacha20-poly1305"

	hashers: {
		algorithm: "bcrypt"
		bcrypt: cost: 8
	}

	identity: default_schema_url: "file:///etc/config/person.schema.json"
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
						"credentials": "password": "identifier": true
						"recovery": "via":     "email"
						"verification": "via": "email"
					}
				}
			}
			"additionalProperties": false
		}
	}
}

_hydra_config: {
	serve: {
		admin: port:  4445
		public: port: 4444
		tls: allow_termination_from: ["10.0.0.0/8", "172.16.0.0/12", "192.168.0.0/16"]
	}
	urls: {
		self: issuer: "http://localhost:4444"
		self: public: "http://localhost:4444"
		consent: "https://\(_hostname)/hydra/consent"
		login: "https://\(_hostname)/hydra/login"
		logout: "https://\(_hostname)/logout"
	}
}