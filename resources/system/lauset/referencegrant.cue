package kube

let namespaces = ["grrrr", "hass", "monitoring"]

k: ReferenceGrant: "lauset-auth": spec: {
	from: [
		for ns in namespaces {
			group:     "gateway.networking.k8s.io"
			kind:      "HTTPRoute"
			namespace: ns
		},
	]
	to: [{
		group: ""
		kind:  "Service"
		name:  "lauset"
	}]
}
