package kube

import "encoding/yaml"

k: PodLogs: "kubernetes-pods": spec: {
	pipelineStages: [{
		cri: {}
	}]
	namespaceSelector: any: true
	selector: matchLabels: {}
}

k: LogsInstance: primary: spec: {
	clients: [{
		url: "http://loki.monitoring.svc.cluster.local:3100/loki/api/v1/push"
	}]

	logsExternalLabelName: ""

	podLogsNamespaceSelector: {}
	podLogsSelector: {}

	additionalScrapeConfigs: {
		name: "grafana-agent-primary-logs-additional-scrape-configs"
		key:  "config.yaml"
	}
}

k: Secret: "grafana-agent-primary-logs-additional-scrape-configs": stringData: "config.yaml": yaml.Marshal([{
	job_name: "systemd-journal"
	journal: {
		labels: namespace: "systemd-journal"
		path: "/var/log/journal"
	}
	relabel_configs: [{
		source_labels: ["__journal__systemd_unit"]
		target_label: "systemd_unit"
	}, {
		source_labels: ["__journal__hostname"]
		target_label: "nodename"
	}, {
		source_labels: ["__journal_syslog_identifier"]
		target_label: "syslog_identifier"
	}]
}])

k: GrafanaAgent: "grafana-agent": spec: {
	logLevel:           "info"
	serviceAccountName: "grafana-agent"
	metrics: instanceSelector: {}
	logs: instanceSelector: {}
}

k: HelmRepository: "grafana": spec: url: "https://grafana.github.io/helm-charts"

k: HelmRelease: "grafana-agent-operator": spec: {
	chart: spec: {
		version: otherTags["grafana/helm-charts/agent-operator"]
		chart:   "grafana-agent-operator"
		sourceRef: name: "grafana"
	}
	values: kubeletService: namespace: ""
}

k: ServiceAccount: "grafana-agent": {}

k: ClusterRole: "grafana-agent": {
	rules: [{
		apiGroups: [""]
		resources: [
			"nodes",
			"nodes/proxy",
			"nodes/metrics",
			"services",
			"endpoints",
			"pods",
			"events",
		]
		verbs: [
			"get",
			"list",
			"watch",
		]
	}, {
		apiGroups: ["networking.k8s.io"]
		resources: ["ingresses"]
		verbs: [
			"get",
			"list",
			"watch",
		]
	}, {
		nonResourceURLs: [
			"/metrics",
			"/metrics/cadvisor",
		]
		verbs: ["get"]
	}]
}

k: ClusterRoleBinding: "grafana-agent": {
	roleRef: {
		apiGroup: "rbac.authorization.k8s.io"
		kind:     "ClusterRole"
		name:     "grafana-agent"
	}
	subjects: [{
		kind:      "ServiceAccount"
		name:      "grafana-agent"
		namespace: "monitoring"
	}]
}
