package kube

import (
	"encoding/json"
	"encoding/yaml"
)

k: ConfigMap: "kratos-config": data: {
	"kratos.yaml":        yaml.Marshal(_kratos_config)
	"person.schema.json": json.Marshal(_person_schema)
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
