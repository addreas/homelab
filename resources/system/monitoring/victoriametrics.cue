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

k: GrafanaDatasource: "vmsingle-main": spec: datasource: {
	name:      "VictoriaMetrics"
	type:      "prometheus"
	url:       "http://vmsingle-main.monitoring.svc:8429"
	access:    "proxy"
	isDefault: false
	basicAuth: false
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
