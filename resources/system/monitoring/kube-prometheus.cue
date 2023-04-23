package kube

import (
	"strings"
	encodingJson "encoding/json"
	m "github.com/prometheus-operator/kube-prometheus/manifests"
)

k: GrafanaDashboard: {
	for name, content in m.grafanaDashboards {
		"grafana-dashboard-\(strings.TrimSuffix(name, ".json"))": spec: source: inline: json: encodingJson.Marshal(content)
	}
}

for kind, resources in m.alertmanager & m.blackboxExporter & m.kubePrometheus & m.kubeStateMetrics & m.kubernetesControlPlane & m.nodeExporter & m.prometheus & m.prometheusAdapter & m.prometheusOperator {
	k: (kind): resources
}

k: Prometheus: "k8s": spec: {
	externalUrl: "https://prometheus-k8s.addem.se"

	prometheusExternalLabelName: ""
	replicaExternalLabelName:    ""

	podMetadata: annotations: "kubectl.kubernetes.io/default-container": "prometheus"

	storage: emptyDir: {}

	remoteWrite: [{url: "http://vmsingle-main.monitoring.svc:8429/api/v1/write"}]

	// [=~"MonitorSelector"]: matchExpressions: [{key: "kube-prometheus-scrape", operator: "Exists"}]
	// remoteRead: [{url: "http://vmsingle-main.monitoring.svc:8429/api/v1/read"}]
}
k: ClusterRole: "prometheus-k8s-namespaced": rules: k.Role."monitoring/prometheus-k8s".rules

k: ClusterRoleBinding: "prometheus-k8s-namespaced": {
	roleRef: {
		apiGroup: "rbac.authorization.k8s.io"
		kind:     "ClusterRole"
		name:     k.ClusterRole."prometheus-k8s-namespaced".metadata.name
	}
	subjects: k.RoleBinding."monitoring/prometheus-k8s".subjects
}

k: GrafanaDatasource: "prometheus": spec: datasource: {
	name:      "Prometheus"
	type:      "prometheus"
	url:       "http://prometheus-k8s.monitoring.svc:9090"
	access:    "proxy"
	isDefault: true
	basicAuth: false
}

k: Ingress: "prometheus-k8s": _authproxy: true

k: Alertmanager: "main": spec: {
	externalUrl: "https://alertmanager-main.addem.se"

	podMetadata: annotations: "kubectl.kubernetes.io/default-container": "alertmanager"
}

k: Ingress: "alertmanager-main": _authproxy: true
