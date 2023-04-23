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

k: {
	for kind, resources in m.kubernetesControlPlane & m.kubePrometheus & m.kubeStateMetrics & m.prometheusAdapter & m.nodeExporter if kind != "NetworkPolicy" {
		(kind): resources
	}
}

for R in k.PrometheusRule {
	k: VMRule: "\(R.metadata.name)": {
		metadata: R.metadata
		spec:     R.spec
	}
}
