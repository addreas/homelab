package kube

import "encoding/yaml"

k: HelmRepository: "vector": spec: url: "https://helm.vector.dev"

k: HelmRelease: "vector-agent": spec: {
	chart: spec: {
		chart:   "vector"
		version: "0.17.0"
		sourceRef: name: "vector"
	}
	values: {
		role: "Agent"
		podMonitor: enabled: true
		customConfig: yaml.Marshal({
			data_dir: "/vector-data-dir"
			api: {
				enabled:    true
				address:    "0.0.0.0:8686"
				playground: true
			}
			sources: {
				kubernetes_logs: type: "kubernetes_logs"
				journald: {
					type:              "journald"
					current_boot_only: true
				}
				host_metrics: type:     "host_metrics"
				internal_metrics: type: "internal_metrics"
			}
			sinks: {
				prom_exporter: {
					type: "prometheus_exporter"
					inputs: ["host_metrics", "internal_metrics", "kubernetes_logs", "journald"]
					address: "0.0.0.0:9090"
				}
				stdout: {
					type: "console"
					inputs: ["kubernetes_logs", "journald"]
					encoding: codec: "json"
				}
				loki: {
					type: "loki"
					inputs: ["kubernetes_logs", "journald"]
					endpoint: "http://loki.monitoring.svc.cluster.local:3100"
					labels: {
						"pod_labels_*": "{{ kubernetes.pod_labels }}"
					}
					compression: "snappy"
					encoding: codec: "json"
				}
			}
		})
	}
}
