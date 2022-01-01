package kube

import "github.com/prometheus-operator/kube-prometheus/manifests"

k: CustomResourceDefinition: manifests.prometheusOperator.CustomResourceDefinition

k: { for kind, resource in manifests.kubeStateMetrics if kind != "ServiceMonitor" { "\(kind)": resource } }
k: { for kind, resource in manifests.prometheusAdapter if kind != "ServiceMonitor" { "\(kind)": resource } }

let promRules = [
	manifests.kubePrometheus.PrometheusRule."kube-prometheus-rules",
	manifests.kubeStateMetrics.PrometheusRule."kube-state-metrics-rules"
]

let serviceMonitors = [
	for _, r in manifests.kubernetesControlPlane if r.kind != _|_ { r }
] + [
	manifests.kubeStateMetrics.ServiceMonitor."kube-state-metrics",
	manifests.prometheusAdapter.ServiceMonitor."prometheus-adapter",
]

for R in promRules  {
	k: VMRule: "\(R.metadata.name)": {
		metadata: R.metadata
		spec: R.spec
	}
}

for S in serviceMonitors {
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

