package kube

let hostNames = ["soltidtabellen.se", "www.soltidtabellen.se"]

k: Ingress: soltidtabellen: {
	spec: {
		rules: [ for h in hostNames {
			host: h
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
