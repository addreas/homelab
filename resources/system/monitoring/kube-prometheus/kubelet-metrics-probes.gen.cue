package kube

k: VMNodeScrape: "kubelet-metrics-probes": {
	apiVersion: "operator.victoriametrics.com/v1beta1"
	kind:       "VMNodeScrape"
	metadata: {
		labels: {
			"app.kubernetes.io/component": "kubernetes"
			"app.kubernetes.io/name":      "kubelet"
			"app.kubernetes.io/part-of":   "kube-prometheus"
		}
		name:      "kubelet-metrics-probes"
		namespace: "monitoring"
	}
	spec: {
		bearerTokenFile: "/var/run/secrets/kubernetes.io/serviceaccount/token"
		honorLabels:     true
		interval:        "30s"
		max_scrape_size: "64MB"
		path:            "/metrics/probes"
		port:            "10250"
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
