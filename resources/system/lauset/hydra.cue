package kube

import "encoding/yaml"

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
