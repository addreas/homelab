package kube

k: Service: hass2: {
	_selector: "app": "hass"
	spec: ports: [{
		name: "http"
		port: 8123
	}]
}

k: ServiceMonitor: hass: {
	_selector: "app": "hass"
	spec: endpoints: [{
		port:     "http"
		interval: "60s"
		path:     "/api/prometheus"
	}]
}

k: Ingress: hass2: {
	metadata: annotations: "cert-manager.io/cluster-issuer": "addem-se-letsencrypt"
	spec: {
		tls: [{
			hosts: ["hass2.addem.se"]
			secretName: "hass2-cert"
		}]
		rules: [{
			host: "hass2.addem.se"
			http: paths: [{
				path:     "/"
				pathType: "Prefix"
				backend: service: {
					name: "hass2"
					port: number: 8123
				}
			}]
		}]
	}
}
