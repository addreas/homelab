package kube

import (
	"encoding/json"
	"encoding/yaml"
)

k: Secret: kratos: stringData: {
	DSN:                         "postgres://kratos:kratos@postgres:5432/kratos"
	COURIER_SMTP_CONNECTION_URI: "smtps://test:test@mailslurper:1025/?skip_ssl_verify=true"
	SECRETS_COOKIE:              "PLEASE-CHANGE-ME-I-AM-VERY-INSECURE"
	SECRETS_CIPHER:              "32-LONG-SECRET-NOT-SECURE-AT-ALL"
}

k: ConfigMap: "kratos-config": data: {
	"kratos.yaml":        yaml.Marshal(_kratos_config)
	"person.schema.json": json.Marshal(_person_schema)
}

k: Deployment: kratos: spec: template: spec: {
	containers: [_probes & {
		name:  "kratos"
		image: "oryd/kratos:\(githubReleases["ory/hydra"])"
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

k: Job: "kratos-migrate": spec: template: spec: {
	restartPolicy: "OnFailure"
	containers: [{
		name:  "migrate"
		image: "oryd/kratos:\(githubReleases["ory/hydra"])"
		command: ["kratos"]
		args: [
			"migrate",
			"sql",
			"-e",
			"-y",
		]
		envFrom: [{secretRef: name: "kratos"}]
	}]
}
