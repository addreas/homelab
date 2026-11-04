package kube

k: HelmRepository: "metrics-server": spec: url: "https://kubernetes-sigs.github.io/metrics-server"

k: HelmRelease: "metrics-server": spec: {
	chart: spec: {
		chart:   "metrics-server"
		version: "3.14.0"
	}
	values: {
		replicas: 1
		// metrics: enabled: true
		// serviceMonitor: enabled: true
	}
}
