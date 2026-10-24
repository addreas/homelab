package kube

k: VLSingle: logs: spec: {
	retentionPeriod: "1"
	storage: resources: requests: storage: "100Gi"
}

k: GrafanaDatasource: victorialogs: spec: {
	plugins: [{name: "victoriametrics-logs-datasource", version: "latest"}]
	datasource: {
		name:      "victorialogs"
		type:      "victoriametrics-logs-datasource"
		url:       "http://vlsingle-logs.monitoring.svc.cluster.local:9428"
		access:    "proxy"
		isDefault: false
		basicAuth: false
		jsonData: logLevelRules: [
			{field: "response_flags", operator: "regex", value: "^(UF|UH|UR|SI)$", level: "error"},
			{field: "response_code", operator: "greaterThan", value: 499, level: "error"},
			{field: "response_code", operator: "greaterThan", value: 399, level: "warning"},
			{field: "response_code", operator: "greaterThan", value: 0, level: "info"},
		]
	}
}

k: VLAgent: collector: spec: {
	k8sCollector: enabled: true

	tolerations: [{
		key:    "node-role.kubernetes.io/control-plane"
		effect: "NoSchedule"
	}]

	remoteWrite: [{
		url: "http://vlsingle-logs.monitoring.svc:9428/internal/insert"
	}]

	remoteWriteSettings: {
		tmpDataPath:        "/vlagent"
		maxDiskUsagePerURL: "1GiB"
	}

	storage: volumeClaimTemplate: spec: resources: requests: storage: "5Gi"
}

k: VMAlert: logs: spec: {
	datasource: url: "http://vlsingle-logs.monitoring.svc:9428"
	notifier: url:   "http://vmalertmanager-alertmanager.monitoring.svc:9093"

	ruleSelector: matchLabels: ruler: "logs"
	ruleNamespaceSelector: {}

	evaluationInterval: "30s"

	remoteWrite: url: "http://vmsingle-metrics.monitoring.svc:8429"
	remoteRead: url:  "http://vmsingle-metrics.monitoring.svc:8429"
}
