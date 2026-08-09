package kube

k: HTTPRoute: "auth": spec: {
	hostnames: ["auth.addem.se", "q2.addem.se"]
	rules: [{
		matches: [
			{type: "Exact", path: "/.well-known/ory/webauthn.js"},
			{type: "PathPrefix", path: "/self-service"},
			{type: "PathPrefix", path: "/sessions"},
		]
		backendRefs: [{
			name: "kratos-public"
			port: 80
		}]
	}, {
		matches: [
			{type: "Exact", path: "/userinfo"},
			{type: "PathPrefix", path: "/oauth2"},
			{type: "Exact", path: "/.well-known/openid-configuration"},
			{type: "Exact", path: "/.well-known/jwks.json"},
		backendRefs: [{
			name: "hydra-public"
			port: 80
		}]

	}, {
		backendRefs: [{
			name: "lauset"
			port: 80
		}]
	}]
}

