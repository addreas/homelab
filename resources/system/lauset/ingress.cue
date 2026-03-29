package kube

_hostname: "auth.addem.se"

k: Ingress: "ory": {
	metadata: annotations: "ingress.kubernetes.io/rewrite-target": "/"
	spec: {
		tls: [{
			hosts: [_hostname]
			secretName: "ory-cert"
		}]
		rules: [{
			host: _hostname
			http: paths: [{
				path: "/kratos"
				backend: service: {
					name: "kratos-public"
					port: name: "http"
				}
			}, {
				path:     "/hydra"
				pathType: "Prefix"
				backend: service: {
					name: "hydra-public"
					port: name: "http"
				}
			}]
		}]
	}
}

k: Ingress: "lauset": {
	spec: {
		tls: [{
			hosts: [_hostname]
			secretName: "ory-cert"
		}]
		rules: [{
			host: _hostname
			http: paths: [{}, {
				path:     "/hydra/consent"
				pathType: "Exact"
				backend: service: {
					name: "lauset"
					port: name: "http"
				}
			}, {
				path:     "/hydra/login"
				pathType: "Exact"
				backend: service: {
					name: "lauset"
					port: name: "http"
				}
			}]
		}]
	}
}
