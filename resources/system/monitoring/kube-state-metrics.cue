package kube

k: HelmRelease: "kube-state-metrics": spec: {
	chart: spec: {
		version: "4.0.2"
		sourceRef: name: "prometheus-community"
	}
	values: prometheus: monitor: enabled: true
}
