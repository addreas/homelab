package kube

import (
	"encoding/json"
	"encoding/yaml"
)

k: Namespace: ory: {}

k: [string]: [string]: metadata: namespace: "ory"

k: Deployment: [string]: spec: template: spec: containers: [...{
	securityContext: _ | *{
		capabilities: drop: ["ALL"]
		privileged:             false
		readOnlyRootFilesystem: true
		runAsNonRoot:           true
		runAsUser:              1000
	}
}]

k: Secret: kratos: stringData: {
	DSN:                         "postgres://kratos:kratos@postgres:5432/kratos"
	COURIER_SMTP_CONNECTION_URI: "smtps://test:test@mailslurper:1025/?skip_ssl_verify=true"
	SECRETS_COOKIE:              "PLEASE-CHANGE-ME-I-AM-VERY-INSECURE"
	SECRETS_CIPHER:              "32-LONG-SECRET-NOT-SECURE-AT-ALL"
}

k: ConfigMap: "kratos-config": data: {
	"kratos.yaml":        yaml.Marshal(config)
	"person.schema.json": json.Marshal(schema)
}

let config = {
	serve: {
		public: {
			base_url: "https://kratos.addem.se/api"
			cors: enabled: false
		}
		admin: base_url: "http://kratos:4434/"
	}

	selfservice: {
		default_browser_return_url: "https://kratos.addem.se/"
		whitelisted_return_urls: ["https://kratos.addem.se/"]

		methods: password: enabled: true

		flows: {
			error: ui_url: "https://kratos.addem.se/error"

			settings: {
				ui_url:                     "https://kratos.addem.se/settings"
				privileged_session_max_age: "15m"
			}

			recovery: {
				enabled: true
				ui_url:  "https://kratos.addem.se/recovery"
			}

			verification: {
				enabled: true
				ui_url:  "https://kratos.addem.se/verification"
				after: default_browser_return_url: "https://kratos.addem.se/"
			}

			logout: after: default_browser_return_url: "https://kratos.addem.se/"

			login: {
				ui_url:   "https://kratos.addem.se/login"
				lifespan: "10m"
			}

			registration: {
				lifespan: "10m"
				ui_url:   "https://kratos.addem.se/registration"
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

let schema = {
	"$id":     "https://kratos.addem.se/person.schema.json"
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
