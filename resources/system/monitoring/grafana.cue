package kube

import "strings"

k: OAuth2Client: "grafana": spec: {
	clientName: "grafana"
	grantTypes: ["authorization_code", "refresh_token"]
	redirectUris: ["https://grafana.addem.se/login/generic_oauth"]
	secretName:  "grafana-oauth2-client-credentials"
	scope:       "openid email"
	skipConsent: true
}

k: Grafana: grafana: spec: {
	config: {
		server: root_url: "https://grafana.addem.se/"
		users: {
			default_theme:        "light"
			auto_assign_org_role: "Admin"
		}
		auth: {
			disable_login_form:   "true"
			disable_signout_menu: "false"
			signout_redirect_url: "https://auth.addem.se/hydra/oauth2/sessions/logout"
			oauth_auto_login:     "true"
		}
		// "log": level: "debug"
		// "log.console": level: "debug"
		"auth.anonymous": enabled: "false"
		"auth.generic_oauth": {
			enabled:             "true"
			client_id:           "$__file{/etc/grafana/oauth-creds/client_id}"
			client_secret:       "$__file{/etc/grafana/oauth-creds/client_secret}"
			scopes:              "openid email"
			auth_url:            "https://auth.addem.se/hydra/oauth2/auth"
			token_url:           "https://auth.addem.se/hydra/oauth2/token"
			api_url:             "https://auth.addem.se/hydra/userinfo"
			role_attribute_path: "Admin"
			// use_pkce:            true
		}
		// dashboards: default_home_dashboard_path: "/etc/grafana/home-dash/dashboard.json"
		alerting: enabled:         "false"
		security: allow_embedding: "true"
	}
	deployment: spec: template: spec: {
		containers: [{
			name:  "grafana"
			image: "grafana/grafana:\(strings.TrimPrefix(githubReleases["grafana/grafana"], "v"))"
			volumeMounts: [{
				name:      "oauth-creds"
				mountPath: "/etc/grafana/oauth-creds/"
			}, {
				name:      "home-dash"
				mountPath: "/etc/grafana/home-dash"
			}]
		}]
		volumes: [{
			name: "oauth-creds"
			secret: secretName: "grafana-oauth2-client-credentials"
		}, {
			name: "home-dash"
			configMap: name: "grafana-home-dashboard"
		}]
	}
	ingress: {
		metadata: annotations: "cert-manager.io/cluster-issuer": "addem-se-letsencrypt"
		spec: {
			rules: [{
				host: "grafana.addem.se"
			}]
			tls: [{
				hosts: ["grafana.addem.se"]
				secretName: "grafana-cert"
			}]
		}
	}
}

k: GitRepository: "grafana-operator": spec: {
	// ref: tag: goModVersions["github.com/grafana-operator/grafana-operator/v4"]
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
	targetNamespace: "monitoring"
	prune:           false // CRDs are included so prune becomes messy...
	images: [{
		name:    "ghcr.io/grafana-operator/grafana-operator"
		newName: "ghcr.io/addreas/grafana-operator"
		newTag:  "v5.1.0-pre-alpha.1"
	}]
}
