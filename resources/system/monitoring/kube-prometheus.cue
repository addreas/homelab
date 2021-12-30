package kube

import "github.com/prometheus-operator/kube-prometheus/manifests"

k: CustomResourceDefinition: manifests.CustomResourceDefinition

for kind in ["ClusterRole", "ClusterRoleBinding", "Deployment", "Service", "ServiceAccount"] {
	k: "\(kind)": "kube-state-metrics": manifests[kind]."kube-state-metrics"
}

for name in ["kube-prometheus-rules", "kube-state-metrics-rules"] {
	let R = manifests.PrometheusRule[name]
	k: VMRule: "\(name)": {
		metadata: labels: "app.kubernetes.io/name": R.metadata.labels."app.kubernetes.io/name"
		spec: R.spec
	}
}

let serviceEndpointMapping = {
	"metricRelabelings": "metricRelabelConfigs"
	"relabelings":       "relabelConfigs"
	"proxyUrl":          "proxyURL"
}

k: PodMonitor: "kube-proxy": manifests.PodMonitor."kube-proxy"

for name in ["kube-apiserver", "coredns", "kube-controller-manager", "kube-scheduler", "kubelet", "kube-state-metrics"] {
	let S = manifests.ServiceMonitor[name]
	k: VMServiceScrape: "\(name)": {
		metadata: labels: "app.kubernetes.io/name": S.metadata.labels."app.kubernetes.io/name"
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
