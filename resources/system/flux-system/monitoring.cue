package kube

k: GrafanaDashboard: "flux-cluster": spec: url:       "https://raw.githubusercontent.com/fluxcd/flux2-monitoring-example/main/monitoring/configs/dashboards/cluster.json"
k: GrafanaDashboard: "flux-control-plane": spec: url: "https://raw.githubusercontent.com/fluxcd/flux2-monitoring-example/main/monitoring/configs/dashboards/control-plane.json"

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
			"source-watcher",
			"kustomize-controller",
			"helm-controller",
			"notification-controller",
			"image-reflector-controller",
			"image-automation-controller",
			"cue-controller",
		]
	}]
}
