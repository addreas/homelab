package kube

k: Ingress: hass: {
	metadata: annotations: "cert-manager.io/cluster-issuer": "addem-se-letsencrypt"
	spec: {
		tls: [{
			hosts: ["hass.addem.se"]
			secretName: "hass-cert"
		}]
		rules: [{
			host: "hass.addem.se"
			http: paths: [{
				path:     "/"
				pathType: "Prefix"
				backend: service: {
					name: "hass"
					port: name: "http"
				}
			}]
		}]
	}
}

k: Service: hass: {
	spec: {
		type:         "ExternalName"
		externalName: "hass.localdomain"
		ports: [{
			name: "http"
			port: 8123
		}]
	}
}
