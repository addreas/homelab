package kube

import (
	"strings"
	encodingJson "encoding/json"
	"github.com/kubernetes-monitoring/kubernetes-mixin:mixin"
	"github.com/kubernetes-monitoring/kubernetes-mixin/dashboards"
)

k: VMRule: "kubernetes-mixin-alerts": spec: mixin.alerts
k: VMRule: "kubernetes-mixin-rules": spec:  mixin.rules

k: GrafanaDashboard: {
	for name, content in dashboards {
		"grafana-dashboard-\(strings.TrimSuffix(name, ".json"))": spec: json: encodingJson.Marshal(content)
	}
}
