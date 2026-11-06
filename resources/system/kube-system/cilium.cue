package kube

k: GrafanaDashboard: "cilium": spec: url: "https://raw.githubusercontent.com/cilium/cilium/v1.20.1/install/kubernetes/cilium/files/cilium-agent/dashboards/cilium-dashboard.json"

k: VMNodeScrape: "cilium-agent": spec: {
	scheme:      "http"
	honorLabels: true
	interval:    "30s"
	port:        "9962"
}

k: ServiceMonitor: "cilium-envoy": {
	_selector: "k8s-app": "cilium-envoy"
	spec: endpoints: [{
		port:     "envoy-metrics"
		interval: "30s"
	}]
}

k: PodMonitor: "cilium-operator": {
	_selector: "io.cilium/app": "operator"
	spec: podMetricsEndpoints: [{
		port:     "prometheus"
		interval: "30s"
	}]
}
