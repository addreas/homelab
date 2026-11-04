package kube

// GitHub webhook endpoint for the homelab Receiver. The receiver path is
// /hook/<token> (token lives in the homelab-receiver-webhook-token secret), the
// notification-controller serves it; no lauset auth here, GitHub can not log in.
k: HTTPRoute: flux: {
	// receivers are served on the webhook-receiver service (-> notification-controller:9292)
	_defaultBackendRef: {
		name: "webhook-receiver"
		port: 80
	}
	spec: {
		hostnames: ["flux.addem.se"]
		rules: [{
			matches: [{path: {type: "PathPrefix", value: "/hook/"}}]
			backendRefs: [_defaultBackendRef]
		}]
	}
}
