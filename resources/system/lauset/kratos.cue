package kube

k: Deployment: "kratos": spec: template: spec: {
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
		env: [{
			name: "DSN"
			valueFrom: secretKeyRef: {
				name: "kratos-db-app"
				key:  "uri"
			}
		}]
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
		env: [{
			name: "DSN"
			valueFrom: secretKeyRef: {
				name: "kratos-db-app"
				key:  "uri"
			}
		}]
		volumeMounts: [{
			name:      "config"
			mountPath: "/etc/config"
			readOnly:  true
		}]
	}]
	volumes: [{
		name: "config"
		configMap: name: "kratos"
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

k: PostgresCluster: "kratos-db": spec: {
	instances: 1
	storage: size: "1Gi"
}
