package kube

k: Ingress: fogis: {
	metadata: annotations: "cert-manager.io/cluster-issuer": "addem-se-letsencrypt"
	spec: {
		tls: [{
			hosts: ["fogis.addem.se"]
			secretName: "fogis-cert"
		}]
		rules: [{
			host: "fogis.addem.se"
			http: paths: [{
				path:     "/"
				pathType: "Prefix"
				backend: service: {
					name: "fogis"
					port: number: 3000
				}
			}]
		}]
	}
}

k: Service: fogis: {
	_selector: Labels
	spec: ports: [{
		name: "http"
		port: 3000
	}]
}

k: ServiceMonitor: fogis: {
	_selector: Labels
	spec: endpoints: [{
		port:     "http"
		interval: "60s"
		path:     "/"
	}]
}
