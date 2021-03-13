package kube

k: Ingress: bitwarden: {
	metadata: annotations: {
		"cert-manager.io/cluster-issuer":     "addem-se-letsencrypt"
		"ingress.kubernetes.io/ssl-redirect": "true"
		"ingress.kubernetes.io/config-backend": """
			option forwardfor header X-Real-IP
			"""
	}
	spec: {
		tls: [{
			hosts: ["bitwarden.addem.se"]
			secretName: "bitwarden-cert"
		}]
		rules: [{
			host: "bitwarden.addem.se"
			http: paths: [{
				path:     "/"
				pathType: "Prefix"
				backend: service: {
					name: "bitwarden"
					port: number: 8080
				}
			}, {
				path:     "/notifications/hub"
				pathType: "Exact"
				backend: service: {
					name: "bitwarden"
					port: number: 3012
				}
			}]
		}]
	}
}

k: Service: bitwarden: {
	_selector: "app": "bitwarden"
	spec: {
		ports: [{
			name: "http"
			port: 8080
		}, {
			name: "websocket"
			port: 3012
		}]
	}
}
