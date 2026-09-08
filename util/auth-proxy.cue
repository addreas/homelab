package util

// For HTTPRoute rules `filters: [utils.#AuthProxy]`
#AuthProxy: {
	type: "ExternalAuth"
	externalAuth: {
		protocol: "HTTP"
		backendRef: {
			name:      "lauset"
			namespace: "ory"
			port:      80
		}
		http: {
			path: "/check"
			allowedHeaders: ["Cookie"]
			allowedResponseHeaders: ["Location"]
		}
	}
}
