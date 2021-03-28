package kube

import "github.com/addreas/homelab/util"

k: GrafanaDashboard: "flux-cluster": spec: url:       "https://raw.githubusercontent.com/fluxcd/flux2/main/manifests/monitoring/grafana/dashboards/cluster.json"
k: GrafanaDashboard: "flux-control-plane": spec: url: "https://raw.githubusercontent.com/fluxcd/flux2/main/manifests/monitoring/grafana/dashboards/control-plane.json"

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
			"cuebuild-controller"
		]
	}]
}

k: util.prometheusNamespaceRBAC
