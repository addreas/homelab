package kube

let hostNames = ["trippler.se", "www.trippler.se", "trip.jdahl.se"]

k: Ingress: trippler: {
	spec: {
		rules: [ for h in hostNames {
			host: h
			http: paths: [{
				path:     "/"
				pathType: "Prefix"
				backend: service: {
					name: "trippler"
					port: name: "http"
				}
			}]
		}]
	}
}

k: Service: trippler: spec: ports: [{
	name: "http"
}]
