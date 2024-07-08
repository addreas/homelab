package kube

k: OAuth2Client: "authproxy": spec: {
	clientName: "authproxy"
	grantTypes: ["client_credentials", "authorization_code", "refresh_token"]
	redirectUris: ["https://authproxy.addem.se/oauth2/callback"]
	secretName:  "authproxy-oauth2-client-credentials"
	scope:       "openid email profile"
	skipConsent: true
}

k: Deployment: "authproxy": spec: template: spec: containers: [{
	image: "quay.io/oauth2-proxy/oauth2-proxy:latest"
	ports: [{
		name:          "http"
		containerPort: 4180
	}]
	envFrom: [{
		secretRef: name: "authproxy-oauth2-client-credentials"
	}]
	args: [
		"--http-address=0.0.0.0:4180",
		"--client-id=$(CLIENT_ID)",
		"--client-secret=$(CLIENT_SECRET)",
		"--cookie-domain=.addem.se",
		"--cookie-secret=$(CLIENT_SECRET)234567",
		"--cookie-secure",
		"--cookie-samesite=strict",
		"--email-domain=*",
		"--oidc-issuer-url=https://auth.addem.se/hydra/",
		"--reverse-proxy",
		"--prompt=login",
		"--provider=oidc",
		"--upstream=static://202",
		"--whitelist-domain=.addem.se",
	]
}]

k: Service: "authproxy": {}

k: Ingress: "authproxy": {}
