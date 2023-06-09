package kube

k: Ingress: prototyp: {
	spec: {
		rules: [{
			host: "prototyp.jdahl.se"
			http: paths: [{
				path:     "/"
				pathType: "Prefix"
				backend: service: {
					name: "prototyp"
					port: name: "http"
				}
			}]
		}]
	}
}

k: Service: prototyp: {}

k: Deployment: "prototyp": {
	spec: {
		replicas: 1
		template: {
			spec: {
				imagePullSecrets: [{name: "regcred"}]
				containers: [{
					image:           "ghcr.io/jonasdahl/prototype:main"
					imagePullPolicy: "Always"
					name: "prototyp"
					ports: [{containerPort: 3000, name: "http"}]
				}]
			}
		}
	}
}

_PodKiller & {
	_name: "deployproto"
	_namespace: "trippler"
	_labelSelector: "app=prototype"
}
