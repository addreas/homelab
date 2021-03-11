package kube

k: HelmRepository: grafana: spec: {
	interval: "1h"
	url:      "https://grafana.github.io/helm-charts"
}

k: HelmRelease: grafana: spec: {
	interval: "1h"
	chart: spec: {
		chart:   "grafana"
		version: "6.4.4"
		sourceRef: {
			kind:      "HelmRepository"
			name:      "grafana"
			namespace: "monitoring"
		}
		interval: "1h"
	}
	values: {
		"grafana.ini": {
			server: root_url: "https://grafana.addem.se/"
			auth: {
				disable_login_form:   true
				disable_signout_menu: true
			}
			"auth.anonymous": {
				enabled:  true
				org_role: "Admin"
			}
		}

		plugins: ["grafana-piechart-panel"]

		sidecar: dashboards: {
			enabled:          true
			folderAnnotation: "grafana_dashboard"
			provider: foldersFromFilesStructure: true
		}

		datasources: "datasources.yaml": {
			apiVersion: 1
			datasources: [{
				name:      "Prometheus"
				type:      "prometheus"
				url:       "http://prometheus-k8s.monitoring.svc:9090"
				access:    "proxy"
				isDefault: true
				editable:  false
			}]
		}

		serviceMonitor: enabled: true

		ingress: {
			enabled: true
			annotations: {
				"cert-manager.io/cluster-issuer": "addem-se-letsencrypt"
				// ingress.kubernetes.io/auth-tls-error-page: getcert.addem.se
				"ingress.kubernetes.io/auth-tls-secret":        "default/client-auth-root-ca-cert"
				"ingress.kubernetes.io/auth-tls-strict":        "true"
				"ingress.kubernetes.io/auth-tls-verify-client": "on"
			}
			hosts: [
				"grafana.addem.se",
			]
			tls: [{
				hosts: ["grafana.addem.se"]
				secretName: "grafana-cert"
			}]
		}
	}
}
