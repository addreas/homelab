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

// Presence of cf-ray: request came through the cloudflare tunnel.
#TunnelMatch: {
	headers: [{
		type:  "RegularExpression"
		name:  "cf-ray"
		value: ".*"
	}]
}
