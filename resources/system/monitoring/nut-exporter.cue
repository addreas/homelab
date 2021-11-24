package kube

k: HelmRelease: "prometheus-nut-exporter": spec: {
	chart: spec: {
		version: "1.0.1"
		sourceRef: {
			name:      "k8s-at-home"
			namespace: "flux-system"
		}
	}
	values: serviceMonitor: {
		enabled: true
		targets: [{
			hostname: "sergio.localdomain"
			port:     3493
		}]
	}
}
