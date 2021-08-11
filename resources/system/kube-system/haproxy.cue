package kube

k: HelmRepository: "haproxy-ingress": {
	spec: {
		interval: "1h"
		url:      "https://haproxy-ingress.github.io/charts"
	}
}

k: HelmRelease: haproxy: {
	spec: {
		interval: "1h"
		chart: spec: {
			chart:   "haproxy-ingress"
			version: ">= 0.12.1"
			sourceRef: {
				kind:      "HelmRepository"
				name:      "haproxy-ingress"
				namespace: "kube-system"
			}
			interval: "1h"
		}
		values: controller: {
			stats: enabled:   true
			metrics: enabled: true
			serviceMonitor: {
				enabled:  true
				interval: "60s"
			}
			replicaCount: 2
			logs: enabled:           true
			extraArgs: {
				"watch-ingress-without-class": "true"
				"allow-cross-namespace":       "true"
			}
		}
	}
}

k: GrafanaDashboard: haproxy: spec: {
	url: "https://grafana.com/api/dashboards/12693/revisions/1/download"
	datasources: [{
		datasourceName: "Prometheus"
		inputName:      "DS_PROMETHEUS"
	}]
}
