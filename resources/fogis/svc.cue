package kube

k: Ingress: fogis: {}

k: Service: fogis: spec: ports: [{
	name: "http"
}]
