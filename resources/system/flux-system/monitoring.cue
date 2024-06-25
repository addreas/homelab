package kube

k: GrafanaDashboard: "flux-cluster": spec: source: remote: url:       "https://raw.githubusercontent.com/fluxcd/flux2-monitoring-example/main/monitoring/configs/dashboards/cluster.json"
k: GrafanaDashboard: "flux-control-plane": spec: source: remote: url: "https://raw.githubusercontent.com/fluxcd/flux2-monitoring-example/main/monitoring/configs/dashboards/control-plane.json"
k: GrafanaDashboard: "flux-logs": spec: source: remote: url:          "https://raw.githubusercontent.com/fluxcd/flux2-monitoring-example/main/monitoring/configs/dashboards/logs.json"

k: PodMonitor: "gotk-monitor": spec: {
	podMetricsEndpoints: [{
		port:     "http-prom"
		interval: "60s"
	}]
	selector: matchExpressions: [{
		key:      "app"
		operator: "In"
		values: [
			"source-controller",
			"kustomize-controller",
			"helm-controller",
			"notification-controller",
			"cue-controller",
		]
	}]
}
