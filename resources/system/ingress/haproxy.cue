package kube

import (
	"strings"
	"encoding/yaml"
)

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
			"http-log-format": #"'{"server_response_send_time":%Tr,"response_time":%Td,"session_duration":%Tt,"request_termination_state":"%tsc","request_method":"%HM","request_uri":"%[capture.req.uri,json(utf8s)]","request_http_version":"%HV","host":"%[capture.req.hdr(0)]","referer":"%[capture.req.hdr(1),json(utf8s)]","x_forward_for":"%[capture.req.hdr(2),json(utf8s)]","backend_name":"%b","status":%ST,"response_size":%B,"request_size":%U}'"#
			"config-frontend": """
				http-request capture req.hdr(Host) len 1000
				http-request capture req.hdr(Referer) len 1000
				http-request capture req.hdr(X-Forwarded-For) len 50
				"""

			// "modsecurity-endpoints":  "coraza-spoa.ingress.svc.cluster.local:9000"
			// "modsecurity-use-coraza": "true"
			// "modsecurity-args":       "app=hdr(host) id=unique-id src-ip=src src-port=src_port dst-ip=dst dst-port=dst_port method=method path=path query=query version=req.ver headers=req.hdrs body=req.body"
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

// k: Deployment: "coraza-spoa": spec: {
// 	replicas: 1
// 	template: {
// 		spec: {
// 			containers: [{
// 				name:  "coraza-spoa"
// 				image: "ghcr.io/corazawaf/coraza-spoa:main"
// 				// image: "docker.io/jcmoraisjr/coraza-spoa:experimental"
// 				ports: [{
// 					containerPort: 9000
// 					name:          "spop"
// 				}]
// 				livenessProbe: tcpSocket: port: 9000
// 				volumeMounts: [{
// 					name:      "coraza-config"
// 					mountPath: "/etc/coraza-spoa/config.yaml"
// 					// mountPath: "/config.yaml"
// 					subPath:  "config.yaml"
// 					readOnly: true
// 				}, {
// 					name:      "varlog"
// 					mountPath: "/var/log/coraza-spoa"
// 				}]
// 			}]
// 			volumes: [{
// 				name: "coraza-config"
// 				configMap: name: "coraza-config"
// 			}, {
// 				name: "varlog"
// 				emptyDir: {}
// 			}]
// 		}
// 	}
// }

// k: Service: "coraza-spoa": {}

// k: ConfigMap: "coraza-config": data: "config.yaml": yaml.Marshal({
// 	default_application: "default_app"
// 	bind:                "0.0.0.0:9000"
// 	applications: default_app: {
// 		include: [
// 			"/etc/coraza-spoa/coraza.conf",
// 			"/etc/coraza-spoa/crs-setup.conf",
// 			"/etc/coraza-spoa/rules/*.conf",
// 		]

// 		transaction_ttl:          60000
// 		transaction_active_limit: 100000
// 		log_level:                "debug"
// 		log_file:                 "/dev/stdout"
// 	}

// })
