package kube

k: VMNodeScrape: "kubelet-metrics-cadvisor": {
	apiVersion: "operator.victoriametrics.com/v1beta1"
	kind:       "VMNodeScrape"
	metadata: {
		labels: {
			"app.kubernetes.io/component": "kubernetes"
			"app.kubernetes.io/name":      "kubelet"
			"app.kubernetes.io/part-of":   "kube-prometheus"
		}
		name:      "kubelet-metrics-cadvisor"
		namespace: "monitoring"
	}
	spec: {
		bearerTokenFile: "/var/run/secrets/kubernetes.io/serviceaccount/token"
		honorLabels:     true
		honorTimestamps: false
		interval:        "30s"
		max_scrape_size: "64MB"
		metricRelabelConfigs: [{
			action: "drop"
			regex:  "container_(network_tcp_usage_total|network_udp_usage_total|tasks_state|cpu_load_average_10s)"
			sourceLabels: [
				"__name__"
			]
		}, {
			action: "drop"
			regex:  "(container_spec_.*|container_file_descriptors|container_sockets|container_threads_max|container_threads|container_start_time_seconds|container_last_seen);;"
			sourceLabels: ["__name__", "pod", "namespace"]
		}, {
			action: "drop"
			regex:  "(container_blkio_device_usage_total);.+"
			sourceLabels: ["__name__", "container"]
		}]
		path: "/metrics/cadvisor"
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
