package kube

k: HelmRelease: "nut-exporter": spec: {
	interval: "1h"
	chart: spec: {
		chart:   "prometheus-nut-exporter"
		version: "1.0.1"
		sourceRef: {
			kind:      "HelmRepository"
			name:      "k8s-at-home"
			namespace: "flux-system"
		}
		interval: "1h"
	}
	values: serviceMonitor: enabled: true
}
