package kube

import (
	monitoring_v1 "github.com/prometheus-operator/prometheus-operator/pkg/apis/monitoring/v1"
	"github.com/prometheus-operator/kube-prometheus/manifests"
)

k: CustomResourceDefinition: manifests.CustomResourceDefinition

k: VMRule: "kube-prometheus-rules": {
	metadata: labels: "app.kubernetes.io/name": "kube-prometheus"
	spec: manifests.PrometheusRule["kube-prometheus-rules"].spec
}

let endpointMapping = {
	"metricRelabelings": "metricRelabelConfigs"
	"relabelings":       "relabelConfigs"
	"proxyUrl":          "proxyURL"
}

let util = {
	S: monitoring_v1.#ServiceMonitor

	spec: {
		for key, value in S.spec if key != "endpoints" {
			"\(key)": _ | *value
		}
		endpoints: [ for endpoint in S.spec.endpoints {
			for key, value in endpoint {
				"\(*endpointMapping[key] | key)": _ | *value
			}
		}]
	}
}

k: VMServiceScrape: "kube-apiserver": {
	metadata: labels: "app.kubernetes.io/name": "apiserver"
	spec: (util & {S: manifests.ServiceMonitor["kube-apiserver"]}).spec
}

k: VMServiceScrape: "coredns": {
	metadata: labels: "app.kubernetes.io/name": "coredns"
	spec: (util & {S: manifests.ServiceMonitor["coredns"]}).spec
}

k: VMNodeScrape: "kubelet": {
	metadata: labels: "app.kubernetes.io/name": "kubelet"
	spec: (util & {S: manifests.ServiceMonitor["kubelet"]}).spec.endpoints[0]
	spec: port: "10250"
}

k: VMNodeScrape: "cadvisor": {
	metadata: labels: "app.kubernetes.io/name": "cadvisor"
	spec: (util & {S: manifests.ServiceMonitor["kubelet"]}).spec.endpoints[1]
	spec: port: "10250"
}

k: VMNodeScrape: "kubelet-probes": {
	metadata: labels: "app.kubernetes.io/name": "kubelet-probes"
	spec: (util & {S: manifests.ServiceMonitor["kubelet"]}).spec.endpoints[2]
	spec: port: "10250"
}
