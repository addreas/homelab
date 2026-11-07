package kube

import "encoding/yaml"

k: VMSingle: metrics: spec: {
	retentionPeriod: "2y"
	storage: resources: requests: storage: "100Gi"
	extraArgs: "dedup.minScrapeInterval": "30s"
}

k: GrafanaDatasource: alertmanager: spec: datasource: {
	name:      "alertmanager"
	type:      "alertmanager"
	url:       "http://vmalertmanager-alertmanager.monitoring.svc.cluster.local:9093"
	access:    "proxy"
	basicAuth: false
	jsonData: {
		implementation:             "prometheus"
		handleGrafanaManagedAlerts: true
	}
}

k: GrafanaDatasource: prometheus: spec: {
	plugins: [{name: "grafana-metricsdrilldown-app", version: "latest"}]
	datasource: {
		name:      "prometheus"
		type:      "prometheus"
		url:       "http://vmauth-unified.monitoring.svc.cluster.local:8427"
		access:    "proxy"
		isDefault: true
		basicAuth: false
		jsonData: {
			manageAlerts:   true
			prometheusType: "Prometheus"
		}
	}
}

k: VMAgent: scrape: spec: {
	selectAllByDefault: true

	externalLabels: cluster: "qb"
	scrapeInterval: "30s"

	extraArgs: "promscrape.maxScrapeSize": "64MB"

	remoteWrite: [{
		url: "http://vmsingle-metrics.monitoring.svc:8429/api/v1/write"
	}]

}

k: VMAlert: metrics: spec: {
	datasource: url: "http://vmsingle-metrics.monitoring.svc:8429"
	notifier: url:   "http://vmalertmanager-alertmanager.monitoring.svc:9093"

	ruleSelector: matchLabels: ruler: "metrics"
	ruleNamespaceSelector: {}

	evaluationInterval: "30s"

	remoteWrite: url: "http://vmsingle-metrics.monitoring.svc:8429"
	remoteRead: url:  "http://vmsingle-metrics.monitoring.svc:8429"
}

k: VMAlertmanager: alertmanager: spec: {
	externalURL:  "https://grafana.addem.se/alerting/list"
	replicaCount: 1

	configRawYaml: yaml.Marshal({
		global: resolve_timeout: "5m"

		inhibit_rules: [{
			source_matchers: ["severity = critical"]
			target_matchers: ["severity =~ warning|info"]
			equal:           ["namespace", "alertname"]
		}, {
			source_matchers: ["severity = warning"]
			target_matchers: ["severity = info"]
			equal:           ["namespace", "alertname"]
		}, {
			source_matchers: ["alertname = InfoInhibitor"]
			target_matchers: ["severity = info"]
			equal:           ["namespace"]
		}]

		route: {
			group_by:        ["namespace"]
			group_wait:      "30s"
			group_interval:  "5m"
			repeat_interval: "12h"
			receiver:        "Default"
			routes: [{
				matchers: ["alertname = Watchdog"]
				receiver: "Watchdog"
			}, {
				matchers: ["alertname = InfoInhibitor"]
				receiver: "null"
			}, {
				matchers: ["severity = critical"]
				receiver: "Critical"
			}, {
				matchers: ["severity = warning"]
				receiver: "Warning"
			}]
		}

		receivers: [{
			name: "Default"
		}, {
			name: "Watchdog"
		}, {
			name: "Critical"
			webhook_configs: [{url: "http://hass.hass.svc.cluster.local:8123/api/webhook/alertmanager-critical"}]
		}, {
			name: "Warning"
			webhook_configs: [{url: "http://hass.hass.svc.cluster.local:8123/api/webhook/alertmanager-warning"}]
		}, {
			name: "null"
		}]
	})

	retention: "120h"
	storage: volumeClaimTemplate: spec: resources: requests: storage: "5Gi"
}
