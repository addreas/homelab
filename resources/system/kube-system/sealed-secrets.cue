package kube

k: HelmRepository: "sealed-secrets": {
	spec: {
		interval: "1h"
		url:      "https://bitnami-labs.github.io/sealed-secrets"
	}
}

k: HelmRelease: "sealed-secrets-controller": {
	spec: {
		interval: "1h"
		chart: spec: {
			chart:   "sealed-secrets"
			version: "1.15.0-r2"
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
