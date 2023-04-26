package kube

// TODO: add rules like these: https://github.com/prometheus-community/helm-charts/blob/main/charts/prometheus-smartctl-exporter/rules/rules.txt

k: HelmRepository: "prometheus-community": spec: url: "https://prometheus-community.github.io/helm-charts"

k: HelmRelease: "smartctl-exporter": spec: {
	chart: spec: {
		chart:   "prometheus-smartctl-exporter"
		version: "0.3.1"
		sourceRef: name: "prometheus-community"
	}
	values: {
		serviceMonitor: enabled:  true
		prometheusRules: enabled: true
	}
}
