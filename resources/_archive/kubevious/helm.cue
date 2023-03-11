package kube

k: [string]: [string]: metadata: namespace: "kubevious"

k: HelmRepository: "kubevious": {
	spec: {
		interval: "1h"
		url:      "https://helm.kubevious.io"
	}
}

k: HelmRelease: "kubevious": {
	spec: {
		interval: "1h"
		chart: spec: {
			chart:   "kubevious"
			version: "0.9.13"
			sourceRef: {
				kind:      "HelmRepository"
				name:      "kubevious"
				namespace: "kube-system"
			}
			interval: "1h"
		}
		values: {}
	}
}

k: Ingress: "kubevious": {
	metadata: annotations: {
		"cert-manager.io/cluster-issuer":               "addem-se-letsencrypt"
		"ingress.kubernetes.io/auth-tls-secret":        "default/client-auth-root-ca-cert"
		"ingress.kubernetes.io/auth-tls-strict":        "true"
		"ingress.kubernetes.io/auth-tls-verify-client": "on"
	}
	spec: {
		tls: [{
			hosts: ["kubevious.addem.se"]
			secretName: "kubevious-cert"
		}]
		rules: [{
			host: "kubevious.addem.se"
			http: paths: [{
				path:     "/"
				pathType: "Prefix"
				backend: service: {
					name: "kubevious-ui-clusterip"
					port: number: 80
				}
			}]
		}]
	}
}
