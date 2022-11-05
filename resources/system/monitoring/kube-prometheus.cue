package kube

import (
	"strings"
	encodingJson "encoding/json"
	m "github.com/prometheus-operator/kube-prometheus/manifests"
)

k: CustomResourceDefinition: m.prometheusOperator.CustomResourceDefinition

k: GrafanaDashboard: {
	for name, content in m.grafanaDashboards {
		"grafana-dashboard-\(strings.TrimSuffix(name, ".json"))": spec: json: encodingJson.Marshal(content)
	}
}

let things = m.kubernetesControlPlane & m.kubePrometheus & m.kubeStateMetrics & m.prometheusAdapter & m.nodeExporter

for kind, resources in things if kind != "NetworkPolicy" {
	k: "\(kind)": resources
}

for N in things.NetworkPolicy {
	k: NetworkPolicy: "\(N.metadata.name)": {
		metadata: N.metadata
		spec: {
			for key, value in N.spec if key != "ingress" {
				(key): value
			}

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

// let kubeletEndpoints = [ for e in k.ServiceMonitor.kubelet.spec.endpoints {
// 	port:           "10250"
// 	relabelConfigs: e.relabelConfigs + [{
// 		targetLabel: "job"
// 		replacement: "kubelet"
// 	}]

// 	for key, value in e if key != "port" && key != "relabelConfigs" {
// 		(key): value
// 	}
// }]

// k: VMNodeScrape: "kubelet-metrics": spec: kubeletEndpoints[0]

// k: VMNodeScrape: "kubelet-cadvisor": spec: kubeletEndpoints[1]

// k: VMNodeScrape: "kubelet-probes": spec: kubeletEndpoints[2]
