package kube

k: HelmRelease: "prometheus-node-exporter": spec: {
	chart: spec: {
		version: "2.2.0"
		sourceRef: name: "prometheus-community"
	}
	values: prometheus: monitor: enabled: true
}
