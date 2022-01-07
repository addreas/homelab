package kube

k: Job: "kratos-migrate": spec: template: spec: {
	restartPolicy: "OnFailure"
	containers: [{
		name:  "migrate"
		image: "oryd/kratos:v0.8.0-alpha.3"
		command: ["kratos"]
		args: [
			"migrate",
			"sql",
			"-e",
			"-y",
		]
		envFrom: [{secretRef: name: "kratos"}]
		securityContext: runAsUser: 0
	}]
}

k: Deployment: kratos: spec: template: spec: {
	containers: [{
		name:  "kratos"
		image: "oryd/kratos:v0.8.0-alpha.3"
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
		// livenessProbe: httpGet: {
		//  path: "/health/alive"
		//  port: "http-admin"
		// }
		// readinessProbe: httpGet: {
		//  path: "/health/ready"
		//  port: "http-admin"
		// }
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
	ports: [{
		port:       80
		targetPort: "http-admin"
		name:       "http"
	}]
	selector: app: "kratos"
}

k: Service: "kratos-public": spec: {
	ports: [{
		port:       80
		targetPort: "http-public"
		name:       "http"
	}]
	selector: app: "kratos"
}
