package kube

k: Ingress: bitwarden: {
	metadata: annotations: {
		"ingress.kubernetes.io/ssl-redirect": "true"
		"ingress.kubernetes.io/config-backend": """
			option forwardfor header X-Real-IP
			"""
	}
	spec: {
		rules: [{
			http: paths: [{}, {
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

k: Service: bitwarden: {}
