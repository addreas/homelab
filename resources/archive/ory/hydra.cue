package kube

import "encoding/yaml"

_hydraTag: "v1.10.7"

k: Secret: hydra: stringData: {
	SECRETS_SYSTEM: "NGc0QTY2Sk14NWpuTFZvN0p4ZFVmZlNQYzFpUk9wVkY="
	SECRETS_COOKIE: "bHZPQUphY1o3WWNyN2RBMUprRnpxWU5HRmZrWmhpRTI="
	DSN:            "postgres://kratos:kratos@postgres:5432/hydra"
}

k: ConfigMap: hydra: data: "config.yaml": yaml.Marshal(_hydra_config)

k: Deployment: hydra: spec: template: spec: {
	volumes: [{
		name: "hydra-config-volume"
		configMap: name: "hydra"
	}]
	containers: [_probes & {
		name:  "hydra"
		image: "oryd/hydra:\(_hydraTag)"
		command: ["hydra"]
		args: [
			"serve",
			"all",
			"--config",
			"/etc/config/config.yaml",
			"--dangerous-force-http",
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
	type: "ClusterIP"
	ports: [{
		port:       4445
		targetPort: "http-admin"
		name:       "http"
	}]
	selector: app: "hydra"
}

k: Service: "hydra-public": spec: {
	type: "ClusterIP"
	ports: [{
		port:       4444
		targetPort: "http-public"
		name:       "http"
	}]
	selector: app: "hydra"
}

k: Job: "hydra-migrate": spec: template: spec: {
	restartPolicy: "OnFailure"
	containers: [{
		name:  "migrate"
		image: "oryd/hydra:\(_hydraTag)"
		command: ["hydra"]
		args: [
			"migrate",
			"sql",
			"-e",
			"-y",
		]
		envFrom: [{secretRef: name: "hydra"}]
	}]
}