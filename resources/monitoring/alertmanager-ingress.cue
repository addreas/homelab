package kube

k: Ingress: alertmanager: {
	metadata: annotations: {
		"cert-manager.io/cluster-issuer": "addem-se-letsencrypt"
		// ingress.kubernetes.io/auth-tls-error-page: getcert.addem.se
		"ingress.kubernetes.io/auth-tls-secret":        "default/client-auth-root-ca-cert"
		"ingress.kubernetes.io/auth-tls-strict":        "true"
		"ingress.kubernetes.io/auth-tls-verify-client": "on"
	}
	spec: {
		tls: [{
			hosts: ["alertmanager.addem.se"]
			secretName: "alertmanager-cert"
		}]
		rules: [{
			host: "alertmanager.addem.se"
			http: paths: [{
				path:     "/"
				pathType: "Prefix"
				backend: service: {
					name: "alertmanager-main"
					port: number: 9093
				}
			}]
		}]
	}
}
