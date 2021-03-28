package kube

k: HelmRepository: "cert-manager": spec: {
	interval: "1h"
	url:      "https://charts.jetstack.io"
}

k: HelmRelease: "cert-manager": spec: {
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
