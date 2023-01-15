package kube

import "encoding/yaml"

k: Secret: hydra: stringData: {
	SECRETS_SYSTEM: "NGc0QTY2Sk14NWpuTFZvN0p4ZFVmZlNQYzFpUk9wVkY="
	SECRETS_COOKIE: "bHZPQUphY1o3WWNyN2RBMUprRnpxWU5HRmZrWmhpRTI="
	DSN:            "postgres://hydra:hydra@postgres:5432/hydra"
}

k: ConfigMap: hydra: data: "config.yaml": yaml.Marshal(_hydra_config)

k: Deployment: hydra: spec: template: spec: {
	volumes: [{
		name: "hydra-config-volume"
		configMap: name: "hydra"
	}]
	initContainers: [{
		name:  "migrate"
		image: "oryd/hydra:\(githubReleases["ory/hydra"])"
		command: ["hydra"]
		args: [
			"migrate",
			"sql",
			"-e",
			"-y",
		]
		envFrom: [{secretRef: name: "hydra"}]
	}]
	containers: [_probes & {
		image: "oryd/hydra:\(githubReleases["ory/hydra"])"
		command: ["hydra"]
		args: [
			"serve",
			"all",
			"--config",
			"/etc/config/config.yaml",
		]
		envFrom: [{secretRef: name: "hydra"}]
		ports: [{
			name:          "http-public"
			containerPort: 4444
		}, {
			name:          "http-admin"
			containerPort: 4445
		}]
		volumeMounts: [{
			name:      "hydra-config-volume"
			mountPath: "/etc/config"
			readOnly:  true
		}]
	}]
}

k: Service: "hydra-admin": spec: {
	selector: app: "hydra"
	ports: [{
		port:       80
		targetPort: "http-admin"
		name:       "http"
	}]
}

k: Service: "hydra-public": spec: {
	selector: app: "hydra"
	ports: [{
		port:       80
		targetPort: "http-public"
		name:       "http"
	}]
}
