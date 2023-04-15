package kube

k: GrafanaDashboard: "unifi-controller": spec: {
	source: remote: grafanaCom: id: 9390
	datasources: [{
		datasourceRef: name:      "prometheus"
		datasourceRef: namespace: "monitoring"
		inputName: "DS_PROMETHEUS"
	}]
}

k: ServiceMonitor: "unifi-controller": spec: endpoints: [{
	interval: "60s"
	port:     "metrics"
}]
