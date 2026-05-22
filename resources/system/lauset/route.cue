package kube

k: HTTPRoute: "auth": spec: {
	hostnames: ["auth.addem.se", "q2.addem.se"]
	rules: [{
		#ReplacePrefix
		_prefix: "/kratos"
		backendRefs: [{
			name: "kratos-public"
			port: 80
		}]
	}, {
		#ReplacePrefix
		_prefix: "/hydra"
		backendRefs: [{
			name: "hydra-public"
			port: 80
		}]

	}, {
		matches: [
			{path: {type: "Exact", value: "/hydra/login"}},
			{path: {type: "Exact", value: "/hydra/login"}},
			{path: {type: "PathPrefix", value: "/"}},
		]
		backendRefs: [{
			name: "lauset"
			port: 80
		}]
	}]
}

#ReplacePrefix: {
	_prefix: string
	matches: [{
		path: {
			type:  "PathPrefix"
			value: _prefix
		}
	}]
	filters: [{
		type: "URLRewrite"
		urlRewrite: path: {
			type:               "ReplacePrefixMatch"
			replacePrefixMatch: "/"
		}
	}]
}
