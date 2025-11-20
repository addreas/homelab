package kube

let hostNames = ["soltidtabellen.se", "www.soltidtabellen.se"]

k: Ingress: soltidtabellen: {
	spec: {
		rules: [for h in hostNames {
			host: h
			http: paths: [{
				path:     "/"
				pathType: "Prefix"
				backend: service: {
					name: "soltidtabellen"
					port: name: "http"
				}
			}]
		}]
	}
}

k: Service: soltidtabellen: {}

k: Deployment: "soltidtabellen": {
	metadata: labels: "homelab.addem.se/autodeploy": "true"
	spec: {
		template: {
			spec: {
				imagePullSecrets: [{name: "regcred"}]
				containers: [{
					name:            "soltidtabellen"
					image:           "ghcr.io/jonasdahl/soltidtabellen.se:main"
					imagePullPolicy: "Always"
					ports: [{containerPort: 3000, name: "http"}]
				}]
			}
		}
	}
}
