package kube

import (
	"encoding/yaml"
)

k: VMSingle: "main": spec: {
	retentionPeriod:      "20w"
	removePvcAfterDelete: true
	resources: {
		requests: {
			cpu:    "500m"
			memory: "512Mi"
		}
		limits: {
			cpu:    "4"
			memory: "4Gi"
		}
	}
	storage: {
		accessModes: ["ReadWriteOnce"]
		resources: requests: storage: "20Gi"
	}
}

k: GrafanaDatasource: "prometheus": spec: datasource: {
	name:      "Prometheus"
	type:      "prometheus"
	url:       "http://vmsingle-main.monitoring.svc:8429"
	access:    "proxy"
	isDefault: true
	basicAuth: false
}

k: VMAgent: "main": spec: {
	for type in ["serviceScrape", "podScrape", "probe", "nodeScrape", "staticScrape"] {
		"\(type)Selector": {}
		"\(type)NamespaceSelector": {}
	}
	selectAllByDefault: true
	podMetadata: annotations: "kubectl.kubernetes.io/default-container": "vmagent"
	replicaCount: 1
	resources: {
		requests: {
			cpu:    "250m"
			memory: "350Mi"
		}
		limits: {
			cpu:    "500m"
			memory: "850Mi"
		}
	}
	extraArgs: "memory.allowedPercent": "40"
	remoteWrite: [{url: "http://vmsingle-main.monitoring.svc:8429/api/v1/write"}]
}

k: VMAlert: "main": spec: {
	replicaCount: 1
	datasource: url: "http://vmsingle-main.monitoring.svc:8429"
	notifiers: [{url: "http://vmalertmanager-main.monitoring.svc:9093"}]
	podMetadata: annotations: "kubectl.kubernetes.io/default-container": "vmalert"
	evaluationInterval: "60s"
	ruleSelector: {}
	resources: {
		requests: {
			cpu:    "150m"
			memory: "350Mi"
		}
		limits: {
			cpu:    "350m"
			memory: "450Mi"
		}
	}
	remoteWrite: url: "http://vmsingle-main.monitoring.svc:8429"
	remoteRead: url:  "http://vmsingle-main.monitoring.svc:8429"
}

k: VMAlertmanager: "main": spec: {
	resources: {
		requests: {
			cpu:    "50m"
			memory: "150Mi"
		}
		limits: {
			cpu:    "100m"
			memory: "250Mi"
		}
	}
	podMetadata: annotations: "kubectl.kubernetes.io/default-container": "alertmanager"
	replicaCount:  1
	configRawYaml: yaml.Marshal({
		// cue import yaml: - < https://github.com/prometheus-operator/kube-prometheus/blob/main/manifests/alertmanager-secret.yaml
		global: resolve_timeout: "5m"
		inhibit_rules: [{
			equal: [
				"namespace",
				"alertname",
			]
			source_matchers: ["severity = critical"]
			target_matchers: ["severity =~ warning|info"]
		}, {
			equal: [
				"namespace",
				"alertname",
			]
			source_matchers: ["severity = warning"]
			target_matchers: ["severity = info"]
		}, {
			equal: ["namespace"]
			source_matchers: ["alertname = InfoInhibitor"]
			target_matchers: ["severity = info"]
		}]
		receivers: [{
			name: "Default"
		}, {
			name: "Watchdog"
		}, {
			name: "Critical"
		}, {
			name: "null"
		}]
		route: {
			group_by: ["namespace"]
			group_interval:  "5m"
			group_wait:      "30s"
			receiver:        "Default"
			repeat_interval: "12h"
			routes: [{
				matchers: ["alertname = Watchdog"]
				receiver: "Watchdog"
			}, {
				matchers: ["alertname = InfoInhibitor"]
				receiver: "null"
			}, {
				matchers: ["severity = critical"]
				receiver: "Critical"
			}]
		}
	})
}

k: Ingress: "alertmanager": {
	_authproxy: true
	spec: {
		rules: [{
			http: paths: [{
				backend: service: {
					name: "vmalertmanager-main"
					port: number: 9093
				}
			}]
		}]
	}
}

k: GitRepository: "victoriametrics-operator": spec: {
	ref: tag: goModVersions["github.com/VictoriaMetrics/operator"]
	url: "https://github.com/victoriametrics/operator"
	ignore: """
		/*
		!/config/
		"""
}

k: Kustomization: "victoriametrics-operator": spec: {
	path:            "./config/default"
	targetNamespace: "monitoring"
	prune:           false
	images: [{
		name:   "victoriametrics/operator"
		newTag: goModVersions["github.com/VictoriaMetrics/operator"]
	}]
	patches: [{
		target: {
			group:   "operator.victoriametrics.com"
			version: "v1beta1"
			kind:    "VMServiceScrape"
			name:    "controller-manager-metrics-monitor"
		}
		patch: yaml.Marshal({
			"$patch":   "delete"
			apiVersion: "operator.victoriametrics.com/v1beta1"
			kind:       "VMServiceScrape"
			metadata: name: "controller-manager-metrics-monitor"
		})
	}]
}
