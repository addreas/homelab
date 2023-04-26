package kube

import "encoding/yaml"

k: MetricsInstance: primary: spec: {
	remoteWrite: [{
		// url: "http://vmsingle.monitoring.svc.cluster.local:8429/api/v1/write"
		url: "http://prometheus-k8s.monitoring.svc.cluster.local:9090/api/v1/write"
	}]

	serviceMonitorNamespaceSelector: {}
	serviceMonitorSelector: {}

	podMonitorNamespaceSelector: {}
	podMonitorSelector: {}

	probeNamespaceSelector: {}
	probeSelector: {}
}

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

	podLogsNamespaceSelector: {}
	podLogsSelector: {}

	additionalScrapeConfigs: {
		name: "grafana-agent-primary-logs-additional-scrape-configs"
		key:  "config.yaml"
	}
}

k: Integration: "node-exporter": spec: {
	name: "node_exporter"
	type: {
		unique:   false
		allNodes: true
	}
	config: {
		autoscrape: {
			enable:           true
			metrics_instance: "monitoring/primary"
		}

		enable_collectors: ["systemd"]

		netdev_device_exclude: "lxc.*"

		rootfs_path: "/host/rootfs"
		sysfs_path:  "/host/sys"
		procfs_path: "/host/proc"
	}
	volumeMounts: [{
		mountPath: "/host/proc"
		name:      "procfs"
		readOnly:  true
	}, {
		mountPath: "/host/sys"
		name:      "sysfs"
		readOnly:  true
	}, {
		mountPath: "/host/rootfs"
		name:      "rootfs"
		readOnly:  true
	}, {
		mountPath: "/run/systemd"
		name:      "run-systemd"
		readOnly:  true
	}]
	volumes: [{
		name: "procfs"
		hostPath: path: "/proc"
	}, {
		name: "sysfs"
		hostPath: path: "/sys"
	}, {
		name: "rootfs"
		hostPath: path: "/"
	}, {
		name: "run-systemd"
		hostPath: path: "/run/systemd"
	}]
}

k: Integration: "eventhandler": spec: {
	name: "eventhandler"
	type: {
		unique:   true
		allNodes: false
	}
	config: logs_instance: "primary"
}

k: Integration: "blackbox": spec: {
	name: "blackbox"
	type: {
		unique:   true
		allNodes: false
	}
	config: {
		autoscrape: {
			enable:           true
			metrics_instance: "monitoring/primary"
		}
		config_file: "/etc/grafana-agent/integrations/configMaps/monitoring/blackbox-exporter-configuration/config.yml"
	}
	configMaps: [{
		name: "blackbox-exporter-configuration"
		key:  "config.yml"
	}]
}

k: PodMonitor: "grafana-agent": spec: {
	podMetricsEndpoints: [{port: "http-metrics"}]
	selector: matchLabels: "app.kubernetes.io/name": "grafana-agent"
}

k: Secret: "grafana-agent-primary-logs-additional-scrape-configs": stringData: "config.yaml": yaml.Marshal([{
	job_name: "systemd-journal"
	journal: {
		labels: namespace: "systemd-journal"
		path: "/run/log/journal"
	}
	relabel_configs: [{
		source_labels: ["__journal__systemd_unit"]
		target_label: "systemd_unit"
	}, {
		source_labels: ["__journal__hostname"]
		target_label: "hostname"
	}]
}])

k: GrafanaAgent: "grafana-agent": spec: {
	logLevel:           "info"
	serviceAccountName: "grafana-agent"
	metrics: instanceSelector: {}
	logs: {
		logsExternalLabelName: ""
		instanceSelector: {}
	}
	integrations: {
		selector: {}
		namespaceSelector: {}
	}

	volumes: [{
		name: "machine-id"
		hostPath: {
			path: "/etc/machine-id"
			type: "File"
		}
	}, {
		name: "run-log-journal"
		hostPath: {
			path: "/run/log/journal"
			type: "Directory"
		}
	}]
	volumeMounts: [{
		name:      "machine-id"
		mountPath: "/etc/machine-id"
		readOnly:  true
	}, {
		name:      "run-log-journal"
		mountPath: "/run/log/journal"
		readOnly:  true
	}]
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
