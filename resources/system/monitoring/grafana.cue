package kube

import (
	"encoding/yaml"
	// "github.com/addreas/homelab/util"
)

k: Grafana: grafana: spec: {
	baseImage: "grafana/grafana:8.3.3"
	config: {
		server: root_url: "https://grafana.addem.se/"
		auth: {
			disable_login_form:   true
			disable_signout_menu: true
		}
		users: default_theme:                    "light"
		dashboards: default_home_dashboard_path: "/etc/grafana-configmaps/grafana-home-dashboard/dashboard.json"
		"auth.anonymous": {
			enabled:  true
			org_role: "Admin"
		}
		alerting: enabled: false
	}
	configMaps: ["grafana-home-dashboard"]
	client: {
		timeout:       5
		preferService: true
	}
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
		path:     "/"
		pathType: "Prefix"
	}
	dashboardLabelSelector: [{
		matchLabels: grafana: "enabled"
	}]
}

k: GitRepository: "grafana-operator": spec: {
	interval: "1h"
	// ref: tag: util.goModVersions["github.com/grafana-operator/grafana-operator/v4"]
	// url: "https://github.com/grafana-operator/grafana-operator.git"
	ref: branch: "master"
	url: "https://github.com/addreas/grafana-operator.git"
	ignore: """
		/*
		!/config
		"""
}

k: Kustomization: "grafana-operator": spec: {
	healthChecks: [{
		kind:      "Deployment"
		name:      "grafana-operator-controller-manager"
		namespace: "monitoring"
	}]
	interval:        "30m"
	path:            "./config/default"
	prune:           true
	targetNamespace: "monitoring"
	patches: [{
		target: {
			group:   "apps"
			version: "v1"
			kind:    "Deployment"
			name:    "controller-manager"
		}
		patch: """
			- op: add
			  path: /spec/template/spec/containers/1/args
			  value:
			  - --scan-all
			- op: replace
			  path: /spec/template/spec/containers/1/image
			  value: ghcr.io/addreas/grafana-operator:v4.1.1
			"""
	}, {
		target: {
			group:   ""
			version: "v1"
			kind:    "Service"
			name:    "controller-manager-metrics-serivce"
		}
		patch: yaml.Marshal({
			"$patch":   "delete"
			apiVersion: "v1"
			kind:       "Service"
			metadata: name: "controller-manager-metrics-service"
		})
	}]
}
