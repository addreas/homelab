package kube

k: Ingress: "unifi-controller": {
	metadata: annotations: {
		"ingress.kubernetes.io/secure-backends": "true"
	}
	spec: {
		tls: [{
			hosts: ["unifi.addem.se"]
			secretName: "unifi-cert"
		}]
		rules: [{
			host: "unifi.addem.se"
		}]
	}
}
