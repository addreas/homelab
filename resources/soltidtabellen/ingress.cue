package kube

k: Ingress: soltidtabellen: {
    spec: {
		rules: [{
			host: "soltidtabellen.se"
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

k: Service: soltidtabellen: spec: ports: [{
	name: "http"
}]
