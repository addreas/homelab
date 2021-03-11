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
			version: "0.12.0-beta.2"
			sourceRef: {
				kind:      "HelmRepository"
				name:      "haproxy-ingress"
				namespace: "kube-system"
			}
			interval: "1h"
		}
		values: controller: {
			replicaCount: 2
			// stats:
			//   enabled: true
			// metrics:
			//   enabled: true
			// serviceMonitor:
			//   enabled: true
			extraArgs: {
				"watch-ingress-without-class": "true"
				"allow-cross-namespace":       "true"
			}
		}
	}
}
