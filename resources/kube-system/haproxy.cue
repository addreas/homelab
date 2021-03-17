package kube

k: HelmRepository: "haproxy-ingress": {
	metadata: namespace: "kube-system"
	spec: {
		interval: "1h"
		url:      "https://haproxy-ingress.github.io/charts"
	}
}

k: HelmRelease: haproxy: {
	metadata: namespace: "kube-system"
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
			stats: enabled: true
			metrics: enabled: true
			serviceMonitor: {
				enabled: true
				interval: "60s"
			}
			logs: enabled: true
			extraArgs: {
				"watch-ingress-without-class": "true"
				"allow-cross-namespace":       "true"
			}
		}
	}
}

k: GrafanaDashboard: haproxy: spec: {
	url: "https://grafana.com/api/dashboards/2428/revisions/7/download"
	datasources: [{
		datasourceName: "Prometheus"
		inputName: "DS_LOCALHOST"
	}]
}
