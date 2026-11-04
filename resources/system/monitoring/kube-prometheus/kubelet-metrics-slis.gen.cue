package kube

k: VMNodeScrape: "kubelet-metrics-slis": {
	apiVersion: "operator.victoriametrics.com/v1beta1"
	kind:       "VMNodeScrape"
	metadata: {
		labels: {
			"app.kubernetes.io/component": "kubernetes"
			"app.kubernetes.io/name":      "kubelet"
			"app.kubernetes.io/part-of":   "kube-prometheus"
		}
		name:      "kubelet-metrics-slis"
		namespace: "monitoring"
	}
	spec: {
		bearerTokenFile: "/var/run/secrets/kubernetes.io/serviceaccount/token"
		honorLabels:     true
		interval:        "5s"
		max_scrape_size: "64MB"
		metricRelabelConfigs: [{
			action: "drop"
			regex:  "process_start_time_seconds"
			sourceLabels: [
				"__name__"
			]
		}]
		path: "/metrics/slis"
		port: "10250"
		relabelConfigs: [{
			action: "replace"
			sourceLabels: [
				"__metrics_path__"
			]
			targetLabel: "metrics_path"
		}, {
			replacement: "kubelet"
			targetLabel: "job"
		}]
		scheme: "https"
		tlsConfig: insecureSkipVerify: true
	}
}
