package kube

k: Namespace: "cert-manager": {}

k: HelmRepository: "cert-manager": {
	metadata: namespace: "cert-manager"
	spec: {
		interval: "1h"
		url:      "https://charts.jetstack.io"
	}
}

k: HelmRelease: "cert-manager": {
	metadata: namespace: "cert-manager"
	spec: {
		interval: "1h"
		chart: spec: {
			chart:   "cert-manager"
			version: "v1.1.0"
			sourceRef: {
				kind:      "HelmRepository"
				name:      "cert-manager"
				namespace: "cert-manager"
			}
			interval: "1m"
		}
		values: installCRDs: true
	}
}

k: ClusterIssuer: "addem-se-letsencrypt": {
	spec: acme: {
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
}

k: SealedSecret: "cloudflare-api-token": {
	metadata: namespace: "cert-manager"
	spec: encryptedData: "api-token": "AgAQ+E0+KOtrhC//Xu2NjZN6Q1qCm4Q7uMa+THYn/2q54SBsqCx3/C5HJ2sCctLLPEGPQdUDaNMhqu5ee3/4f4glkSUKZEmmVIFeMVIxIGCKEwZnRkbDdzstxaUUALQJtD3PfbHzSndGrM9fozvvG0GKFTbflYAKqaReZu/vCm84Igkj+scjJ5JAi8dQbEiwCdm+W4x1/upxCm6+GdkzSciY5wAZZGzD6x17NlTmaVvtIq1SkWpnF6AWxeGoSSMJbTy2KD/c/8ou51/N/P/IGVxUXQxzRIC9OoLBTIw72nca7kLShItTSzIQVlATEH0YJ1DVK6N2hHL9laDQf1uzMmwSkaJ+PrxCwu8wyTWBExqFey1k7SxXQfR/SXaWIahOYJQUvJ6ZaK/dMEdglyBvrEc3YEzzrembLgvIp/L4Fxyg/05w5UW5CU8HxoI5gZ1nmCOcPjJMnhkCBadfrmqA/AedSoO80c+L66qwN1UAoxQI2VQXD6yQmPRthkWgWJkxEyDtX3sYvySDFUkZgg6so0N48uyMv3KBTKkkWTOFDl29BZF4KiMKEH4VVOToJXrH6NCzGo36GfYNjuRFHtub6b5iVNMXxNSiZnyBbJ+QsVq0T6fHwRqinFpNVzTootMJH9yqsL8ga/M95ZvBrWf6fA5muWyvthZzW+9NuU2uM9eHQHAczgxZVC/QkPDmwf3/kH56EI7AvZy1X/TwqKZeZKzjzpkZwM2J8zgvC+FJkzXsI5OUbd0T16uz"
}
