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
