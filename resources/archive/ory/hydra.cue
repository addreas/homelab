package kube

import "encoding/yaml"

_hydraTag: "v1.10.7"

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

k: ConfigMap: hydra: data: "config.yaml": yaml.Marshal({
	existingSecret: ""
	serve: {
		admin: port:  4445
		public: port: 4444
		tls: allow_termination_from: ["10.0.0.0/8", "172.16.0.0/12", "192.168.0.0/16"]
	}
	urls: self: issuer: "http://localhost:4444"
})

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

k: Deployment: hydra: spec: template: spec: {
	volumes: [{
		name: "hydra-config-volume"
		configMap: name: "hydra"
	}]
	containers: [{
		name:  "hydra"
		image: "oryd/hydra:\(_hydraTag)"
		command: ["hydra"]
		volumeMounts: [{
			name:      "hydra-config-volume"
			mountPath: "/etc/config"
			readOnly:  true
		}]
		args: [
			"serve",
			"all",
			"--config",
			"/etc/config/config.yaml",
			"--dangerous-force-http",
		]
		ports: [{
			name:          "http-public"
			containerPort: 4444
		}, {
			name:          "http-admin"
			containerPort: 4445
		}]
		livenessProbe: httpGet: {
			path: "/health/alive"
			port: "http-admin"
		}
		readinessProbe: httpGet: {
			path: "/health/ready"
			port: "http-admin"
		}
		envFrom: [{ secretRef: name: "hydra" }]
	}]
}

k: Secret: hydra: stringData: {
	SECRETS_SYSTEM: "NGc0QTY2Sk14NWpuTFZvN0p4ZFVmZlNQYzFpUk9wVkY="
	SECRETS_COOKIE: "bHZPQUphY1o3WWNyN2RBMUprRnpxWU5HRmZrWmhpRTI="
	DSN: "postgres://kratos:kratos@postgres:5432/hydra"
}
