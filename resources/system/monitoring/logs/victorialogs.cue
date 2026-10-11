package kube

k: VLSingle: logs: spec: {
	retentionPeriod: "1"
	storage: resources: requests: storage: "100Gi"
}

k: GrafanaDatasource: victorialogs: spec: datasource: {
	name:      "victorialogs"
	type:      "victorialogs"
	url:       "http://vlsingle-logs.monitoring.svc.cluster.local:9428"
	access:    "proxy"
	isDefault: false
	basicAuth: false
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

k: VMAlert: "logs": spec: {
	datasource: url: "http://vlsingle-logs.monitoring.svc:9428"
	notifier: url:   "http://vmalertmanager-alerter.monitoring.svc:9093"

	ruleSelector: matchLabels: "ruler": "logs"
	ruleNamespaceSelector: {}

	evaluationInterval: "30s"

	remoteWrite: url: "http://vmsingle-metrics.monitoring.svc:8429"
	remoteRead: url:  "http://vmsingle-metrics.monitoring.svc:8429"
}
