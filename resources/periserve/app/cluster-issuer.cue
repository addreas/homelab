package kube

k: ClusterIssuer: "periserve-letsencrypt": spec: acme: {
	email:          "periserve@jdahl.se"
	server:         "https://acme-v02.api.letsencrypt.org/directory"
	preferredChain: "ISRG Root X1"
	privateKeySecretRef: name: "periserve-letsencrypt-private-key"
	solvers: [{
		dns01: cloudflare: {
			email: "jonas@jdahl.se"
			apiTokenSecretRef: {
				name: "jonas-cloudflare-api-token"
				key:  "api-token"
			}
		}
	}]
}

// There must be a secret named "jonas-cloudflare-api-token" in cert-manager namespace with api-token=CLOUDFLARE_API_TOKEN
