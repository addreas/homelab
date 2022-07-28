package kube

import (
	"strings"
	"encoding/yaml"
)

k: OAuth2Client: "grafana": spec: {
	clientName: "grafana"
	grantTypes: ["authorization_code", "refresh_token"]
	redirectUris: ["https://grafana.addem.se/login/generic_oauth"]
	secretName: "grafana-oauth2-client-credentials"
	scope:      "openid email"
}

k: Grafana: grafana: spec: {
	baseImage: "grafana/grafana:\(strings.TrimPrefix(githubReleases["grafana/grafana"], "v"))"
	config: {
		server: root_url: "https://grafana.addem.se/"
		users: {
			default_theme:        "light"
			auto_assign_org_role: "Admin"
		}
		auth: {
			disable_login_form:   true
			disable_signout_menu: false
			signout_redirect_url: "https://auth.addem.se/hydra/oauth2/sessions/logout"
			oauth_auto_login:     true
		}
		// "log": level: "debug"
		// "log.console": level: "debug"
		"auth.anonymous": enabled: false
		"auth.generic_oauth": {
			enabled:             true
			client_id:           "$__file{/etc/grafana-secrets/grafana-oauth2-client-credentials/client_id}"
			client_secret:       "$__file{/etc/grafana-secrets/grafana-oauth2-client-credentials/client_secret}"
			scopes:              "openid email"
			auth_url:            "https://auth.addem.se/hydra/oauth2/auth"
			token_url:           "https://auth.addem.se/hydra/oauth2/token"
			api_url:             "https://auth.addem.se/hydra/userinfo"
			role_attribute_path: "Admin"
			// use_pkce:            true
		}
		dashboards: default_home_dashboard_path: "/etc/grafana-configmaps/grafana-home-dashboard/dashboard.json"
		alerting: enabled:                       false
		security: allow_embedding:               true
	}
	configMaps: ["grafana-home-dashboard"]
	secrets: ["grafana-oauth2-client-credentials"]
	client: {
		timeout:       5
		preferService: true
	}
	ingress: {
		enabled:       true
		hostname:      "grafana.addem.se"
		tlsEnabled:    true
		tlsSecretName: "grafana-cert"
		annotations: "cert-manager.io/cluster-issuer": "addem-se-letsencrypt"
		path:     "/"
		pathType: "Prefix"
	}
	dashboardLabelSelector: [{
		matchLabels: grafana: "enabled"
	}]
}

k: GitRepository: "grafana-operator": spec: {
	interval: "1h"
	ref: tag: goModVersions["github.com/grafana-operator/grafana-operator/v4"]
	url: "https://github.com/grafana-operator/grafana-operator.git"
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
	targetNamespace: "monitoring"
	// images: [{
	// 	name:    "quay.io/grafana-operator/grafana-operator"
	// 	newName: "quay.io/addreas/grafana-operator"
	// 	newTag:  "test"
	// }]
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
			  - --requeue-delay=30
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
