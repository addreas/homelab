package kube

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
			"up",
			"-e",
			"-y",
		]
		envFrom: [{secretRef: name: "hydra"}]
		env: [{
			name: "DSN"
			valueFrom: secretKeyRef: {
				name: "hydra-db-app"
				key:  "uri"
			}
		}]
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
		env: [{
			name: "DSN"
			valueFrom: secretKeyRef: {
				name: "hydra-db-app"
				key:  "uri"
			}
		}, {
			name:  "ORY_SDK_URL"
			value: "http://localhost:4445"
		}]
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

k: PostgresCluster: "hydra-db": spec: {
	instances: 1
	storage: size: "1Gi"
}
