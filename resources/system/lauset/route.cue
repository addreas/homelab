package kube

k: HTTPRoute: "auth": spec: {
	hostnames: ["auth.addem.se", "q2.addem.se"]
	rules: [{
		matches: [
			{path: {type: "Exact", value: "/.well-known/ory/webauthn.js"}},
			{path: {type: "PathPrefix", value: "/self-service"}},
			{path: {type: "PathPrefix", value: "/sessions"}},
		]
		backendRefs: [{
			name: "kratos-public"
			port: 80
		}]
	}, {
		matches: [
			{path: {type: "Exact", value: "/userinfo"}},
			{path: {type: "Exact", value: "/.well-known/openid-configuration"}},
			{path: {type: "Exact", value: "/.well-known/jwks.json"}},
			{path: {type: "PathPrefix", value: "/oauth2"}},
		]
		backendRefs: [{
			name: "hydra-public"
			port: 80
		}]
	}, {
		// very explicit because /admin is unprotected 😱
		matches: [
			for p in [
				"/",
				"/login",
				"/registration",
				"/verification",
				"/recovery",
				"/consent",
				"/logout",
				"/error",
				"/sessions",
				"/settings",
			] {
				{path: {type: "Exact", value: p}}
			}
		]
		backendRefs: [{
			name: "lauset"
			port: 80
		}]
	}]
}
