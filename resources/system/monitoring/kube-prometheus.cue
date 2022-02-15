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

for kind, resources in things
if kind != "ServiceMonitor" &&
	kind != "PrometheusRule" {
	k: "\(kind)": resources
}

for R in things.PrometheusRule {
	k: VMRule: "\(R.metadata.name)": {
		metadata: R.metadata
		spec:     R.spec
	}
}

for S in things.ServiceMonitor {
	k: VMServiceScrape: "\(S.metadata.name)": {
		metadata: S.metadata
		spec: {
			for key, value in S.spec if key != "endpoints" {
				"\(key)": value
			}
			endpoints: [ for endpoint in S.spec.endpoints {
				for key, value in endpoint {
					"\(*serviceEndpointMapping[key] | key)": value
				}
			}]
		}
	}
}

let serviceEndpointMapping = {
	"metricRelabelings": "metricRelabelConfigs"
	"relabelings":       "relabelConfigs"
	"proxyUrl":          "proxyURL"
}

let kubeletEndpoints = [ for e in k.VMServiceScrape.kubelet.spec.endpoints {
	port:           "10250"
	relabelConfigs: e.relabelConfigs + [{
		targetLabel: "job"
		replacement: "kubelet"
	}]

	for key, value in e if key != "port" && key != "relabelConfigs" {
		(key): value
	}
}]

k: VMNodeScrape: "kubelet-metrics": spec: kubeletEndpoints[0]

k: VMNodeScrape: "kubelet-cadvisor": spec: kubeletEndpoints[1]

k: VMNodeScrape: "kubelet-probes": spec: kubeletEndpoints[2]
