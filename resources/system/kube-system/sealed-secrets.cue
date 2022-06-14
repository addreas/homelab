package kube

k: HelmRepository: "sealed-secrets": spec: {
	interval: "1h"
	url:      "https://bitnami-labs.github.io/sealed-secrets"
}

k: HelmRelease: "sealed-secrets-controller": spec: {
	interval: "1h"
	chart: spec: {
		chart: "sealed-secrets"
		// TODO: version bump tool
		version: "2.0.2"
		sourceRef: {
			kind:      "HelmRepository"
			name:      "sealed-secrets"
			namespace: "kube-system"
		}
		interval: "1h"
	}
}
