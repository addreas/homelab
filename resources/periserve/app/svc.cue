package kube

let HttpBackend = {
	paths: [{
		path:     "/"
		pathType: "Prefix"
		backend: service: {
			name: "periserve"
			port: number: 3000
		}
	}]
}

k: Ingress: periserve: {
	metadata: annotations: {
		"cert-manager.io/cluster-issuer":     "periserve-letsencrypt"
		"ingress.kubernetes.io/ssl-redirect": "true"
	}
	spec: {
		tls: [{
			hosts: ["periserve.com", "www.periserve.com"]
			secretName: "periserve-com-cert"
		}, {
			hosts: ["periserve.se", "www.periserve.se"]
			secretName: "periserve-se-cert"
		}]
		rules: [
			{host: "periserve.se", http:      HttpBackend},
			{host: "www.periserve.se", http:  HttpBackend},
			{host: "periserve.com", http:     HttpBackend},
			{host: "www.periserve.com", http: HttpBackend},
		]
	}
}

k: Service: periserve: {
	spec: ports: [{
		name: "http"
		port: 3000
	}, {
		name: "metrics"
		port: 4000
	}]
}

k: ServiceMonitor: "periserve": spec: endpoints: [{
	port:     "metrics"
	interval: "60s"
}]
