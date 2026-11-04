package kube

k: HTTPRoute: "auth": spec: {
	hostnames: ["auth.addem.se"]
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
		backendRefs: [{
			name: "lauset"
			port: 80
		}]
	}]
}
