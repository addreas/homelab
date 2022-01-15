package kube

k: OAuth2Client: "oauth2-proxy": spec: {
	clientName: "oauth2-proxy"
	redirectUris: ["http://oauth2-proxy.addem.se/*"]
	secretName: "oauth2-proxy-client-credentials"
}

k: Deployment: "oauth2-proxy": spec: template: spec: containers: [{
	name: "proxy"
	image: "quay.io/oauth2-proxy/oauth2-proxy:v7.2.1"
	args: [
		"--provider oidc",
		"--provider-display-name Louset",
		"--client-id oauth2-proxy",
		"--client-secret $(CLIENT_SECRET)",
		"--redirect-url=https://oauth2-proxy.addem.se/oauth2/callback",
		"--oidc-issuer-url http://127.0.0.1:5556/dex",
		"--cookie-secure=true",
		"--cookie-secret=secret",
		"--cookie-domain=.addem.se",
		"--reverse-proxy",
	]
	ports: [{ containerPort: 4180 }]
	env: [{
		name: "CLIENT_SECRET",
		valueFrom: secretKeyRef: {
			name: "oauth2-proxy-client-credentials"
			key: "secret"
		}
	}]
}]

k: Service: "oauth2-proxy": {}

k: Ingress: "oauth2-proxy": {}

k: Deployment: "httpbin": spec: template: spec: containers: [{
	name: "httpbin"
	image: "kennethreitz/httpbin:latest"
	ports: [{ containerPort: 80 }]
}]

k: Service: "httpbin": {}

k: Ingress: "httpbin": metadata: annotations: {
	"ingress.kubernetes.io/oauth": "oauth2-proxy"
	"ingress.kubernetes.io/auth-url": "svc://oauth2-proxy/oauth2/auth"
	"ingress.kubernetes.io/auth-signin": "https://oauth2-proxy.addem.se/oauth2/start?rd=%[path]"
}