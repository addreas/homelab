package kube

import "encoding/yaml"

k: VMSingle: "main": spec: {
	retentionPeriod:      "2w"
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

k: GrafanaDataSource: "prometheus": spec: {
	name: "prometheus.yaml"
	datasources: [{
		name:      "Prometheus"
		type:      "prometheus"
		url:       "http://vmsingle-main.monitoring.svc:8429"
		access:    "proxy"
		isDefault: true
		editable:  false
	}]
}

k: VMAgent: "main": spec: {
	for type in ["serviceScrape", "podScrape", "probe", "nodeScrape", "staticScrape"] {
		"\(type)Selector": {}
		"\(type)NamespaceSelector": {}
	}
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
	replicaCount:  1
	configRawYaml: yaml.Marshal({
		global: resolve_timeout: "5m"
		inhibit_rules: [{
			equal: ["namespace", "alertname"]
			source_match: severity:    "critical"
			target_match_re: severity: "warning|info"
		}, {
			equal: ["namespace", "alertname"]
			source_match: severity:    "warning"
			target_match_re: severity: "info"
		}]
		receivers: [{name: "Default"}, {name: "Watchdog"}, {name: "Critical"}]
		route: {
			group_by: ["namespace"]
			group_interval:  "5m"
			group_wait:      "30s"
			receiver:        "Default"
			repeat_interval: "12h"
			routes: [{
				match: {
					alertname: "Watchdog"
					receiver:  "Watchdog"
				}
			}, {
				match: {
					severity: "critical"
					receiver: "Critical"
				}
			}]
		}
	})
}

k: Ingress: "alertmanager": {
	metadata: annotations: {
		// ingress.kubernetes.io/auth-tls-error-page: getcert.addem.se
		"ingress.kubernetes.io/auth-tls-secret":        "default/client-auth-root-ca-cert"
		"ingress.kubernetes.io/auth-tls-strict":        "true"
		"ingress.kubernetes.io/auth-tls-verify-client": "on"
	}
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
	interval: "1h"
	ref: branch: "master"
	url: "https://github.com/victoriametrics/operator"
	ignore: """
		/*
		!/config/
		"""
}

k: Kustomization: "victoriametrics-operator": spec: {
	interval:        "1h"
	path:            "./config/default"
	targetNamespace: "monitoring"
	images: [{
		name:   "victoriametrics/operator"
		newTag: "v0.19.2-amd64"
		newName: "ghcr.io/addreas/victoriametrics-operator"
	}]
	prune: true
	sourceRef: {
		kind: "GitRepository"
		name: "victoriametrics-operator"
	}
	patches: [{
		target: {
			group: "operator.victoriametrics.com"
			version: "v1beta1"
			kind: "VMServiceScrape"
			name: "controller-manager-metrics-monitor"
		}
		patch: yaml.Marshal({
			"$patch": "delete"
			apiVersion: "operator.victoriametrics.com/v1beta1"
			kind: "VMServiceScrape"
			metadata: name: "controller-manager-metrics-monitor"
		})
	}]
}
