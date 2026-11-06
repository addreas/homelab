package kube

k: PodMonitor: "cert-manager": {
	_selector: "app.kubernetes.io/instance": "cert-manager"
	spec: podMetricsEndpoints: [{
		port:     "http-metrics"
		interval: "30s"
	}]
}

k: GrafanaDashboard: "cert-manager": spec: grafanaCom: id: 20850

k: PrometheusRule: "cert-manager": {
	metadata: labels: {
		role:  "alert-rules"
		ruler: "metrics"
	}
	spec: groups: [{
		name: "cert-manager.rules"
		rules: [{
			alert: "CertManagerCertificateExpiringSoon"
			annotations: {
				description: "Certificate {{ $labels.namespace }}/{{ $labels.name }} expires in less than 14 days."
				summary:     "cert-manager certificate is about to expire."
			}
			expr: "certmanager_certificate_expiration_timestamp_seconds - time() < 86400 * 14"
			for:  "1h"
			labels: severity: "warning"
		}, {
			alert: "CertManagerCertificateNotReady"
			annotations: {
				description: "Certificate {{ $labels.namespace }}/{{ $labels.name }} has not been ready for more than 15 minutes."
				summary:     "cert-manager certificate is not ready."
			}
			expr: "certmanager_certificate_ready_status{condition=\"False\"} == 1"
			for:  "15m"
			labels: severity: "critical"
		}, {
			alert: "CertManagerRenewalOverdue"
			annotations: {
				description: "Certificate {{ $labels.namespace }}/{{ $labels.name }} should have been renewed at {{ $value }} but was not."
				summary:     "cert-manager renewal is overdue."
			}
			expr: "certmanager_certificate_renewal_timestamp_seconds - time() < 0"
			for:  "1h"
			labels: severity: "warning"
		}, {
			alert: "CertManagerACMERequestFailing"
			annotations: {
				description: "ACME client requests are failing for more than 15 minutes."
				summary:     "cert-manager ACME requests are failing."
			}
			expr: "sum(rate(certmanager_http_acme_client_request_count{status!~\"2..\"}[5m])) > 0"
			for:  "15m"
			labels: severity: "warning"
		}]
	}]
}
