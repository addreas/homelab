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
			"syslog-length":       "65535"

			// https://gist.github.com/vr/c9e158e298e6e316544c399b2ff3ef22
			// https://medium.com/thirddev/json-logging-in-haproxy-the-right-way-3636297d2d49
			"http-log-format": #"'{"server_response_send_time":%Tr,"response_time":%Td,"session_duration":%Tt,"request_termination_state":"%tsc","request_method":"%HM","request_uri":"%[capture.req.uri,json(utf8s)]","request_http_version":"%HV","host":"%[capture.req.hdr(0)]","referer":"%[capture.req.hdr(1),json(utf8s)]","backend_name":"%b","status":%ST,"response_size":%B,"request_size":%U}'"#
			"config-frontend": """
				http-request capture req.hdr(Host) len 1000
				http-request capture req.hdr(Referer) len 1000
				"""
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
