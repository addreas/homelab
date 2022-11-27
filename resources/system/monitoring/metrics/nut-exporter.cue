package kube

k: HelmRelease: "prometheus-nut-exporter": spec: {
	chart: spec: {
		version: "5.4.2"
		sourceRef: {
			name:      "k8s-at-home"
			namespace: "flux-system"
		}
	}
	values: metrics: {
		enabled: true
		serviceMonitor: {
			targets: [{
				hostname: "sergio.localdomain"
				port:     3493
			}]
		}
		prometheusRule: {
			enabled: true
			rules: [{
				alert: "UpsStatusUnknown"
				annotations: {
					description: "UPS {{ \"{{ $labels.ups }}\" }} is reporting a status of unknown."
					summary:     "UPS status unknown."
				}
				expr: "nut_status == 0"
				for:  "10s"
				labels: severity: "critical"
			}]
		}
	}
}
