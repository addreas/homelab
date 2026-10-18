package kube

k: HelmRepository: victoriametrics: spec: url: "https://victoriametrics.github.io/helm-charts/"

k: HelmRelease: "victoria-metrics-operator": spec: {
	chart: spec: {
		chart:   "victoria-metrics-operator"
		version: "0.68.1"
		sourceRef: name: "victoriametrics"
	}
	values: {
		enable_converter_ownership: true
		crds: enabled: false
	}
}

k: GitRepository: "victoria-metrics-operator-crds": spec: {
	url: "https://github.com/VictoriaMetrics/operator"
	ref: tag: "v0.75.0"
	ignore: """
		/*
		!/config/crd/overlay/crd.yaml
		"""
}

k: Kustomization: "victoria-metrics-operator-crds": spec: {
	path: "./config/crd/overlay"
	prune: false
	wait:  false
}
