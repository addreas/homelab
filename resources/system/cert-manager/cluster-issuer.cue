package kube

k: ClusterIssuer: "addem-se-letsencrypt": spec: acme: {
	email:          "andreas+acme@addem.se"
	server:         "https://acme-v02.api.letsencrypt.org/directory"
	preferredChain: "ISRG Root X1"
	privateKeySecretRef: name: "addem-se-letsencrypt-private-key"
	solvers: [{
		dns01: cloudflare: {
			email: "addem1234@gmail.com"
			apiTokenSecretRef: {
				name: "cloudflare-api-token"
				key:  "api-token"
			}
		}
	}]
}
