package kube

k: HTTPRoute: bitwarden: spec: rules: [{
	matches: [{path: {type: "Exact", value: "/notifications/hub"}}, {path: {type: "Exact", value: "/notifications/hub/negotiate"}}]
	backendRefs: [{name: "bitwarden", port: 3012}]
}, {
	backendRefs: [{name: "bitwarden", port: 8080}]
}]

k: Service: bitwarden: {}
