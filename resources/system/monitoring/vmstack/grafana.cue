package kube

k: HelmRepository: grafana: spec: url: "https://grafana.github.io/helm-charts/"

k: HelmRelease: "grafana-operator": spec: chart: spec: {
	chart:   "grafana-operator"
	version: "5.25.0"
	sourceRef: name: "grafana"
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
		"auth.anonymous": enabled: "false"
		"auth.generic_oauth": {
			enabled:             "true"
			client_id:           "$__file{/etc/grafana/oauth-creds/CLIENT_ID}"
			client_secret:       "$__file{/etc/grafana/oauth-creds/CLIENT_SECRET}"
			scopes:              "openid email"
			auth_url:            "https://auth.addem.se/hydra/oauth2/auth"
			token_url:           "https://auth.addem.se/hydra/oauth2/token"
			api_url:             "https://auth.addem.se/hydra/userinfo"
			role_attribute_path: "Admin"
		}
		alerting: enabled:         "false"
		security: allow_embedding: "true"
	}
	deployment: spec: template: spec: {
		containers: [{
			name:  "grafana"
			image: "grafana/grafana:13.2.1"
			volumeMounts: [{
				name:      "oauth-creds"
				mountPath: "/etc/grafana/oauth-creds/"
			}]
		}]
		volumes: [{
			name: "oauth-creds"
			secret: secretName: "grafana-oauth2-client-credentials"
		}]
	}
	httpRoute: spec: {
		hostnames: ["grafana.addem.se"]
		parentRefs: [{name: "addem", namespace: "ingress"}]
	}
}

k: OAuth2Client: grafana: spec: {
	secretName: "grafana-oauth2-client-credentials"
	redirectUris: ["https://grafana.addem.se/login/generic_oauth"]
}

k: GrafanaDatasource: prometheus: spec: {
	instanceSelector: {}
	datasource: {
		name:      "prometheus"
		type:      "prometheus"
		url:       "http://vmsingle-metrics.monitoring.svc.cluster.local:8429"
		access:    "proxy"
		isDefault: true
		basicAuth: false
		jsonData: {
			manageAlerts:   true
			prometheusType: "Prometheus"
		}
	}
}

k: GrafanaDatasource: victorialogs: spec: {
	instanceSelector: {}
	datasource: {
		name:      "victorialogs"
		type:      "victorialogs"
		url:       "http://vlsingle-logs.monitoring.svc.cluster.local:9428"
		access:    "proxy"
		isDefault: false
		basicAuth: false
	}
}

let DS_PROMETHEUS = {
	datasourceName: "prometheus"
	inputName:      "DS_PROMETHEUS"
}

let grafanaComDsPrometheus = {
	"k8s-system-api-server": 15761
	"k8s-views-global":      15757
	"k8s-views-namespaces":  15758
	"k8s-views-nodes":       15759
	"k8s-views-pods":        15760
}

for name, grafanaComId in grafanaComDsPrometheus {
	k: GrafanaDashboard: (name): spec: {
		grafanaCom: id: grafanaComId
		instanceSelector: {}
		datasources: [DS_PROMETHEUS]
	}
}
