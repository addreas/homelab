package kube

k: GrafanaDashboard: "unifi-controller": spec: {
	grafanaCom: id: 9390
	datasources: [{
		datasourceName: "Prometheus"
		inputName:      "DS_PROMETHEUS"
	}]
}

k: ServiceMonitor: "unifi-controller": {
	_selector: app: "unifi-controller"
	spec: endpoints: [{
		interval: "60s"
		port:     "metrics"
	}]
}
