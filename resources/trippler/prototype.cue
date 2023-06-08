package kube

k: Ingress: prototyp: {
	spec: {
		rules: [{
			host: "prototyp.jdahl.se"
			http: paths: [{
				path:     "/"
				pathType: "Prefix"
				backend: service: {
					name: "prototyp"
					port: name: "http"
				}
			}]
		}]
	}
}

k: Service: prototyp: {}

let baseContainer = {
	image:           "ghcr.io/jonasdahl/prototype:main"
	imagePullPolicy: "Always"
}

k: Deployment: "prototyp": {
	metadata: labels: "homelab.addem.se/autodeploy": "true"
	spec: {
		replicas: 1
		template: {
			spec: {
				imagePullSecrets: [{name: "regcred"}]
				containers: [baseContainer & {
					name: "prototyp"
					ports: [{containerPort: 3000, name: "http"}]
				}]
			}
		}
	}
}
