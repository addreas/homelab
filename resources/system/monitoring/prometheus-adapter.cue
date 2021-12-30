package kube

k: HelmRelease: "prometheus-adapter": spec: {
	chart: spec: {
		version: "3.0.0"
		sourceRef: name: "prometheus-community"
	}
	values: {
		prometheus: {
			url:  "http://vmsingle-main.monitoring.svc"
			port: "8429"
		}
		rules: resource: {
			window: "3m"
			cpu: {
				containerQuery: #"sum(rate(container_cpu_usage_seconds_total{<<.LabelMatchers>>, container!=""}[3m])) by (<<.GroupBy>>)"#
				nodeQuery:      #"sum(rate(container_cpu_usage_seconds_total{<<.LabelMatchers>>, id='/'}[3m])) by (<<.GroupBy>>)"#
			}
			memory: {
				containerQuery: #"sum(container_memory_working_set_bytes{<<.LabelMatchers>>, container!=""}) by (<<.GroupBy>>)"#
				nodeQuery:      #"sum(container_memory_working_set_bytes{<<.LabelMatchers>>,id='/'}) by (<<.GroupBy>>)"#
			}
			["cpu" | "memory"]: {
				resources: overrides: {
					node: resource:      "node"
					namespace: resource: "namespace"
					pod: resource:       "pod"
				}
				containerLabel: "container"
			}
		}
	}
}

k: VMServiceScrape: "prometheus-adapter": spec: {
	endpoints: [{
		bearerTokenFile: "/var/run/secrets/kubernetes.io/serviceaccount/token"
		interval: "30s"
		port: "https"
		scheme: "https"
		tlsConfig: insecureSkipVerify: true
		metricRelabelConfigs: [{
			action: "drop"
			regex: "(apiserver_client_certificate_.*|apiserver_envelope_.*|apiserver_flowcontrol_.*|apiserver_storage_.*|apiserver_webhooks_.*|workqueue_.*)"
			sourceLabels: ["__name__"]
		}]
	}]
	selector: matchLabels: {
		"app.kubernetes.io/instance": "prometheus-adapter"
		"app.kubernetes.io/name": "prometheus-adapter"
	}
}
