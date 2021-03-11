package kube

k: Ingress: "unifi-controller": {
	metadata: annotations: {
		"cert-manager.io/cluster-issuer":        "addem-se-letsencrypt"
		"ingress.kubernetes.io/secure-backends": "true"
	}
	spec: {
		tls: [{
			hosts: ["unifi.addem.se"]
			secretName: "unifi-cert"
		}]
		rules: [{
			host: "unifi.addem.se"
			http: paths: [{
				path:     "/"
				pathType: "Prefix"
				backend: service: {
					name: "unifi-controller"
					port: number: 8443
				}
			}]
		}]
	}
}
