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
			"syslog-length":       "65536"

			// https://gist.github.com/vr/c9e158e298e6e316544c399b2ff3ef22
			"http-log-format": #"'{"host":"%H","ident":"haproxy","pid":%pid,"time":"%Tl","haproxy":{"conn":{"act":%ac,"fe":%fc,"be":%bc,"srv":%sc},"queue":{"backend":%bq,"srv":%sq},"time":{"tq":%Tq,"tw":%Tw,"tc":%Tc,"tr":%Tr,"tt":%Tt},"termination_state":"%tsc","retries":%rc,"network":{"client_ip":"%ci","client_port":%cp,"frontend_ip":"%fi","frontend_port":%fp},"ssl":{"version":"%sslv","ciphers":"%sslc"},"request":{"method":"%HM","hu":"%HU",hp:"%HP",hq:"%HQ","protocol":"%HV","header":{"host":"%[capture.req.hdr(0),json(utf8s)]","xforwardfor":"%[capture.req.hdr(1),json(utf8s)]","referer":"%[capture.req.hdr(2),json(utf8s)]"}},"name":{"backend":"%b","frontend":"%ft","server":"%s"},"response":{"status_code":%ST,"header":{"xrequestid":"%[capture.res.hdr(0),json(utf8s)]"}},"bytes":{"uploaded":%U,"read":%B}}}'"#
			"config-frontend": """
				capture request header Host len 40
				capture request header X-Forwarded-For len 50
				capture request header Referer len 200
				capture request header User-Agent len 200
				capture response header X-Request-ID len 50
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
