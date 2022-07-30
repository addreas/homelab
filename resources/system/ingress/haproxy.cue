package kube

import "strings"

k: HelmRepository: "haproxy-ingress": {
	spec: {
		url: "https://haproxy-ingress.github.io/charts"
	}
}

k: HelmRelease: haproxy: {
	spec: {
		chart: spec: {
			chart:   "haproxy-ingress"
			version: strings.TrimPrefix(githubReleases["jcmoraisjr/haproxy-ingress"], "v")
			sourceRef: {
				kind: "HelmRepository"
				name: "haproxy-ingress"
			}
		}
		values: controller: {
			replicaCount: 2
			stats: enabled:   false
			metrics: enabled: false
			serviceMonitor: {
				enabled:  false
				interval: "60s"
			}
			logs: enabled: true
			config: {
				"ssl-redirect":        "false"
				"forwardfor":          "ifmissing"
				"fronting-proxy-port": "80"
			}
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
