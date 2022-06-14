package kube

k: HelmRepository: "cert-manager": spec: {
	interval: "1h"
	url:      "https://charts.jetstack.io"
}

k: HelmRelease: "cert-manager": spec: {
	interval: "1h"
	chart: spec: {
		chart:   "cert-manager"
		version: goModVersions["github.com/cert-manager/cert-manager"]
		sourceRef: {
			kind:      "HelmRepository"
			name:      "cert-manager"
			namespace: "cert-manager"
		}
		interval: "1h"
	}
	values: installCRDs: true
}
