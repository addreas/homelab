package kube

// renovate: registryUrl=https://prometheus-community.github.io/helm-charts
k: HelmRelease: "blackbox-exporter": spec: {
	chart: spec: {
		chart:   "prometheus-blackbox-exporter"
		version: "11.21.1"
		sourceRef: name: "prometheus-community"
	}
	values: {
		fullnameOverride: "blackbox-exporter"

		config: modules: http_2xx: {
			prober:  "http"
			timeout: "5s"
			http: {
				valid_http_versions:   ["HTTP/1.1", "HTTP/2.0"]
				follow_redirects:      true
				preferred_ip_protocol: "ip4"
			}
		}

		serviceMonitor: selfMonitor: enabled: true
	}
}
