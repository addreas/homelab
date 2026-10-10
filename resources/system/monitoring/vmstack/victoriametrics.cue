package kube

k: ["VMAlert" | "VMAgent" | "VMAlertmanager" | "VMSingle" | "VLAgent" | "VLSingle"]: [string]: spec: resources: {
	requests: {cpu: "100m", memory: "128Mi"}
	limits: {cpu: "2", memory: "2Gi"}
}

k: HelmRepository: victoriametrics: spec: url: "https://victoriametrics.github.io/helm-charts/"

k: HelmRelease: "victoria-metrics-operator": spec: {
	chart: spec: {
		chart:   "victoria-metrics-operator"
		version: "0.68.1"
		sourceRef: name: "victoriametrics"
	}
	values: enable_converter_ownership: true
}

k: VMSingle: metrics: spec: {
	retentionPeriod: "2y"
	storage: resources: requests: storage: "100Gi"
	extraArgs: "dedup.minScrapeInterval": "30s"
}

k: VMAgent: scrape: spec: {
	selectAllByDefault: true

	externalLabels: cluster: "qb"
	scrapeInterval: "30s"

	remoteWrite: [{
		url: "http://vmsingle-metrics.monitoring.svc:8429/api/v1/write"
	}]

}

k: VMAlert: ruler: spec: {
	datasource: url: "http://vmsingle-metrics.monitoring.svc:8429"
	notifier: url:   "http://vmalertmanager-alerter.monitoring.svc:9093"

	ruleSelector: matchLabels: role: "alert-rules"
	ruleNamespaceSelector: {}

	evaluationInterval: "30s"

	remoteWrite: url: "http://vmsingle-metrics.monitoring.svc:8429"
	remoteRead: url:  "http://vmsingle-metrics.monitoring.svc:8429"
}

k: VMAlertmanager: alerter: spec: {
	externalURL:  "https://alertmanager-main.addem.se"
	replicaCount: 1

	configRawYaml: """
		global:
		  resolve_timeout: 5m
		route:
		  group_by: [alertname, cluster]
		  group_wait: 30s
		  group_interval: 5m
		  repeat_interval: 12h
		  receiver: Critical
		  routes:
		    - matchers: [severity = warning]
		      receiver: Warning
		    - matchers: [severity = error]
		      receiver: Critical
		receivers:
		  - name: Critical
		    webhook_configs:
		      - url: http://hass.default.svc.cluster.local:8123/api/webhook/alertmanager-critical
		  - name: Warning
		    webhook_configs:
		      - url: http://hass.default.svc.cluster.local:8123/api/webhook/alertmanager-warning
		"""

	retention: "120h"
	storage: volumeClaimTemplate: spec: resources: requests: storage: "5Gi"
}

k: VLSingle: logs: spec: {
	retentionPeriod: "1"
	storage: resources: requests: storage: "100Gi"
}

k: VLAgent: collector: spec: {
	k8sCollector: enabled: true

	remoteWrite: [{
		url: "http://vlsingle-logs.monitoring.svc:9428/internal/insert"
	}]

	remoteWriteSettings: {
		tmpDataPath:        "/vlagent"
		maxDiskUsagePerURL: "1GiB"
	}

	storage: volumeClaimTemplate: spec: resources: requests: storage: "5Gi"
}

k: VMAlert: "log-ruler": spec: {
	datasource: url: "http://vlsingle-logs.monitoring.svc:9428"
	notifier: url:   "http://vmalertmanager-alerter.monitoring.svc:9093"

	ruleSelector: matchLabels: "vmalert/type": "logs"
	ruleNamespaceSelector: {}

	evaluationInterval: "30s"

	remoteWrite: url: "http://vmsingle-metrics.monitoring.svc:8429"
	remoteRead: url:  "http://vmsingle-metrics.monitoring.svc:8429"
}
