package kube

import "encoding/yaml"

k: HelmRepository: "prometheus-community": spec: url: "https://prometheus-community.github.io/helm-charts"

k: HelmRelease: "smartctl-exporter": spec: {
	chart: spec: {
		chart:   "prometheus-smartctl-exporter"
		version: "0.3.1"
		sourceRef: name: "prometheus-community"
	}
	values: {
		fullnameOverride: "smartctl-exporter"
		serviceMonitor: enabled:  true
		prometheusRules: enabled: true
	}
	postRenderers: [{
		kustomize: patches: [{
			target: kind: "ServiceMonitor"
			target: name: "smartctl-exporter"
			patch: yaml.Marshal([{
				op:   "add"
				path: "/spec/endpoints/0/relabelings"
				value: [{
					action: "replace"
					sourceLabels: ["__meta_kubernetes_endpoint_node_name"]
					targetLabel: "node"
				},
					for l in ["service", "pod", "job", "endpoint", "container", "namespace"] {
						action: "labeldrop"
						regex:  l
					},
				]
			}, {
				op:   "add"
				path: "/spec/endpoints/0/metricRelabelings"
				value: [{
					action: "drop"
					sourceLabels: ["serial_number"]
					regex: "beaf.*"
				}]
			}])
		}]
	}]
}
