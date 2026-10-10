package kube

// renovate: registryUrl=https://prometheus-community.github.io/helm-charts
k: HelmRelease: "node-exporter": spec: {
	chart: spec: {
		chart:   "prometheus-node-exporter"
		version: "4.59.0"
		sourceRef: name: "prometheus-community"
	}
	values: {
		prometheus: monitor: enabled: true
		extraArgs: ["--no-collector.systemd"]
	}
}
