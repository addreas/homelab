package kube

k: Deployment: "lauset": spec: template: spec: {
	containers: [{
		image:           "ghcr.io/addreas/lauset:latest"
		imagePullPolicy: "Always"
		envFrom: [{configMapRef: name: "lauset"}, {secretRef: name: "lauset"}]
		ports: [{
			name:          "http"
			containerPort: 8000
		}]
	} & _probes]
}

k: Service: "lauset": spec: ports: [{
	port:       80
	targetPort: "http"
	name:       "http"
}]
