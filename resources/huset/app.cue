package kube

k: HTTPRoute: huset: _authproxy: true

k: Service: huset: {}

k: Deployment: huset: {
	metadata: labels: "homelab.addem.se/autodeploy": "true"
	spec: template: spec: {
		imagePullSecrets: [{name: "regcred"}]
		containers: [{
			image:           "ghcr.io/jonasdahl/huset:sha-a11c102"
			imagePullPolicy: "Always"
			ports: [{containerPort: 8080, name: "http"}]
			readinessProbe: httpGet: {path: "/healthz", port: "http"}
			livenessProbe: httpGet: {path: "/healthz", port: "http"}
			resources: {
				requests: {cpu: "10m", memory: "16Mi"}
				limits: memory: "64Mi"
			}
		}]
	}
}

k: Probe: huset: _path: "/healthz"
