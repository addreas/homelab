package kube

k: GrafanaDashboard: "unifi-controller": spec: {
	url: "https://grafana.com/api/dashboards/9390/revisions/1/download"
	datasources: [{
		datasourceName: "Prometheus"
		inputName:      "DS_PROMETHEUS"
	}]
}

k: ServiceMonitor: "unifi-controller": {
	spec: endpoints: [{
		interval: "60s"
		port:     "metrics"
	}]
}
