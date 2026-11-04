package kube

// renovate: registryUrl=https://prometheus-community.github.io/helm-charts
k: HelmRelease: "kube-state-metrics": spec: {
	chart: spec: {
		chart:   "kube-state-metrics"
		version: "8.6.0"
		sourceRef: name: "prometheus-community"
	}
	values: prometheus: monitor: {
		enabled:     true
		honorLabels: true
	}
}
