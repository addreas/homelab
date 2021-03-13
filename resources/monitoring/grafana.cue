package kube


k: Grafana: grafana: spec: {
	config: {
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
	ingress: {
		enabled: true
		hostname: "grafana.addem.se"
		tlsEnabled: true
		tlsSecretName: "grafana-cert"
		annotations: {
			"cert-manager.io/cluster-issuer": "addem-se-letsencrypt"
			// ingress.kubernetes.io/auth-tls-error-page: getcert.addem.se
			"ingress.kubernetes.io/auth-tls-secret":        "default/client-auth-root-ca-cert"
			"ingress.kubernetes.io/auth-tls-strict":        "true"
			"ingress.kubernetes.io/auth-tls-verify-client": "on"
		}
	}
	dashboardLabelSelector: []
}
