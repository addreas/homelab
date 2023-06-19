package kube

import "strings"

k: HelmRepository: "haproxy-ingress": spec: url: "https://haproxy-ingress.github.io/charts"

k: HelmRelease: haproxy: spec: {
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
		metrics: enabled: true
		serviceMonitor: {
			enabled:  true
			interval: "60s"
		}
		config: {
			"ssl-redirect":        "false"
			forwardfor:            "ifmissing"
			"fronting-proxy-port": "80"
			"syslog-endpoint":     "vector.monitoring.svc.cluster.local:9514"
			"syslog-tag":          "haproxy"
			"http-log-format":     "%{+Q}o %{-Q}ci - - [%trg] %r %ST %B \"\" \"\" %cp %ms %ft %b %s %TR %Tw %Tc %Tr %Ta %tsc %ac %fc %bc %sc %rc %sq %bq %CC %CS %hrl %hsl"
		}
		extraArgs: {
			"watch-ingress-without-class": "true"
			"allow-cross-namespace":       "true"
		}
	}
}

//k: GrafanaDashboard: haproxy: spec: {
// grafanaCom: id: 12693
// datasources: [{
//  datasourceRef: name: "prometheus"
//  datasourceRef: namespace: "monitoring"
//  inputName:      "DS_PROMETHEUS"
// }]
//}
