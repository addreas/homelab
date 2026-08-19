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
					name: "lauset"
					port: 80
				}
				http: {
					path: "/check"
					allowedHeaders: ["Cookie", "x-envoy-original-path"]
					allowedResponseHeaders: [
						"Location",
						"X-User-Id",
						"X-User-Email",
						"X-User-Name",
						"X-Auth-Request-User",
						"X-Auth-Request-Email",
						"X-Auth-Request-Preferred-Username",
					]
				}
			}
		}]
		backendRefs: [{
			name: "example-app"
			port: 8080
		}]
	}]
}
