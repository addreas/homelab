package kube

k: Grafana: grafana: spec: {
	baseImage: "grafana/grafana:latest"
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
        alerting: enabled: false
	}
	client: preferService: true
	ingress: {
		enabled:       true
		hostname:      "grafana.addem.se"
		tlsEnabled:    true
		tlsSecretName: "grafana-cert"
		annotations: {
			"cert-manager.io/cluster-issuer": "addem-se-letsencrypt"
			// ingress.kubernetes.io/auth-tls-error-page: getcert.addem.se
			"ingress.kubernetes.io/auth-tls-secret":        "default/client-auth-root-ca-cert"
			"ingress.kubernetes.io/auth-tls-strict":        "true"
			"ingress.kubernetes.io/auth-tls-verify-client": "on"
		}
	}
	dashboardLabelSelector: [{
		matchLabels: grafana: "enabled"
	}]
}

k: GitRepository: "grafana-operator": spec: {
	interval: "1h"
	ref: branch: "master"
	url: "https://github.com/integr8ly/grafana-operator.git"
	ignore: """
		/*
		!/config
		"""
}

k: Kustomization: "grafana-operator": spec: {
	healthChecks: [{
		kind:      "Deployment"
		name:      "grafana-operator"
		namespace: "monitoring"
	}]
	interval: "30m"
	path:     "./config/default"
	prune:    true
	sourceRef: {
		kind: "GitRepository"
		name: "grafana-operator"
	}
	targetNamespace: "monitoring"
}
