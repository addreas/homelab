package kube

let hostNames = ["packlistor.se", "*.packlistor.se"]

k: Ingress: packlistor: {
	spec: {
		rules: [ for h in hostNames {
			host: h
			http: paths: [{
				path:     "/"
				pathType: "Prefix"
				backend: service: {
					name: "packlistor"
					port: name: "http"
				}
			}]
		}]
	}
}

k: Service: packlistor: spec: ports: [{
	name: "http"
}]
