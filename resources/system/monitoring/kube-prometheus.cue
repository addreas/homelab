package kube

import (
	"strings"
	encodingJson "encoding/json"
	m "github.com/prometheus-operator/kube-prometheus/manifests"
)

k: CustomResourceDefinition: m.prometheusOperator.CustomResourceDefinition

k: GrafanaDashboard: {
	for name, content in m.grafanaDashboards {
		"grafana-dashboard-\(strings.TrimSuffix(name, ".json"))": spec: source: inline: json: encodingJson.Marshal(content)
	}
}

k: m.kubernetesControlPlane & m.kubePrometheus & m.kubeStateMetrics & m.prometheusAdapter & m.nodeExporter

for R in things.PrometheusRule {
	k: VMRule: "\(R.metadata.name)": {
		metadata: R.metadata
		spec:     R.spec
	}
}

for N in things.NetworkPolicy {
	k: NetworkPolicy: "\(N.metadata.name)": {
		metadata: N.metadata
		spec: {
			for key, value in N.spec if key != "ingress" {(key): value}
			ingress: [ for i in N.spec.ingress {
				if i.from != _|_ {
					from: i.from + [{
						podSelector: matchLabels: "app.kubernetes.io/name": "vmagent"
					}, {
						podSelector: matchLabels: "app.kubernetes.io/name": "grafana-agent"
					}]
				}
				if i.ports != _|_ {
					ports: i.ports
				}
			}]
		}
	}
}
