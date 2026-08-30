@if(example)

package kube

k: Deployment: "example-app": spec: template: spec: {
	containers: [{
		image: "nginxinc/nginx-unprivileged:alpine"
		securityContext: readOnlyRootFilesystem: false
		ports: [{
			name:          "http"
			containerPort: 8080
		}]
	}]
}

k: Service: "example-app": {}

k: HTTPRoute: "example-app": spec: {
	hostnames: ["example.addem.se"]
	rules: [{
		filters: [{
			type: "ExternalAuth"
			externalAuth: {
				protocol: "HTTP"
				backendRef: {
					name:      "lauset"
					namespace: "ory" // TODO: referencegrant
					port:      80
				}
				http: {
					path: "/check"
					allowedHeaders: ["Cookie"]
					allowedResponseHeaders: ["Location"]
				}
			}
		}]
		backendRefs: [{
			name: "example-app"
			port: 8080
		}]
	}]
}
