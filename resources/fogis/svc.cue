package kube

k: Ingress: fogis: spec: {
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

k: Service: fogis: spec: ports: [{
	name: "http"
	port: 3000
}]
