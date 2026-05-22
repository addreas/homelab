package kube

k: Deployment: "lauset": spec: template: spec: {
	containers: [{
		image:           "ghcr.io/jonasdahl/lauset:latest"
		imagePullPolicy: "Always"
		envFrom: [{configMapRef: name: "lauset"}, {secretRef: name: "lauset"}]
		env: [{
			name:  "LOG_LEVEL"
			value: "debug"
		}, {
			name:  "COOKIE_DOMAIN"
			value: "addem.se"
		}]
		ports: [{
			name:          "http"
			containerPort: 3000
		}]
		volumeMounts: [{
			name:      "home-node"
			mountPath: "/home/node"
		}]
	} & _probes]
	volumes: [{
		name: "home-node"
		emptyDir: {}
	}]
}

k: Service: "lauset": spec: ports: [{
	port:       80
	targetPort: "http"
	name:       "http"
}]
