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
			version: "0.13.4"
			sourceRef: {
				kind:      "HelmRepository"
				name:      "haproxy-ingress
			}
			interval: "1h"
		}
		values: controller: {
			stats: enabled:   false
			metrics: enabled: false
			serviceMonitor: {
				enabled:  false
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

//k: GrafanaDashboard: haproxy: spec: {
// grafanaCom: id: 12693
// datasources: [{
//  datasourceName: "Prometheus"
//  inputName:      "DS_PROMETHEUS"
// }]
//}
