package kube

k: MetricsInstance: primary: spec: {
	remoteWrite: [{
		url: "http://vmsingle-main.monitoring.svc.cluster.local:8429/api/v1/write"
	}]

	serviceMonitorNamespaceSelector: {}
	serviceMonitorSelector: {}

	podMonitorNamespaceSelector: {}
	podMonitorSelector: {}

	probeNamespaceSelector: {}
	probeSelector: {}
}

k: LogsInstance: primary: spec: {
	clients: [{
		url: "http://loki.monitoring.svc.cluster.local:3100/loki/api/v1/push"
	}]

	podLogsNamespaceSelector: {}
	podLogsSelector: {}
}

k: PodLogs: "kubernetes-pods": spec: {
	pipelineStages: [{
		docker: {}
	}]
	namespaceSelector: matchNames: ["default"]
	selector: matchLabels: {}
}

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
