package kube

k: HelmRepository: "sealed-secrets": {
	metadata: namespace: "kube-system"
	spec: {
		interval: "1h"
		url:      "https://bitnami-labs.github.io/sealed-secrets"
	}
}

k: HelmRelease: "sealed-secrets-controller": {
	metadata: namespace: "kube-system"
	spec: {
		interval: "1h"
		chart: spec: {
			chart:   "sealed-secrets"
			version: "1.14.1-r1"
			sourceRef: {
				kind:      "HelmRepository"
				name:      "sealed-secrets"
				namespace: "kube-system"
			}
			interval: "1h"
		}
		values: dashboards: {
			create: true
			labels: grafana_dashboard: "kube-system"
		}
	}
}
