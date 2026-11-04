package kube

k: HTTPRoute: flux: spec: {
	hostnames: ["flux.addem.se"]
	rules: [{
		matches: [{path: {type: "PathPrefix", value: "/hook/"}}]
		backendRefs: [{
			name: "webhook-receiver"
			port: "80"
		}]
	}]
}

k: CiliumNetworkPolicy: "allow-webhooks": spec: {
	endpointSelector: matchLabels: app: "notification-controller"
	ingress: [{
		fromEntities: ["ingress"]
		toPorts: [{ports: [{port: "9292", protocol: "TCP"}]}]
	}]
}
