package kube

k: HelmRepository: victoriametrics: spec: url: "https://victoriametrics.github.io/helm-charts/"

k: HelmRelease: "victoria-metrics-operator": spec: {
	chart: spec: {
		chart:   "victoria-metrics-operator"
		version: "0.68.1"
		sourceRef: name: "victoriametrics"
	}
	values: enable_converter_ownership: true
}
