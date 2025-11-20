package kube

k: Prometheus: "k8s": spec: {
	externalUrl: "https://prometheus-k8s.addem.se"

	prometheusExternalLabelName: ""
	replicaExternalLabelName:    ""

	externalLabels: cluster: "nucles"

	podMetadata: annotations: "kubectl.kubernetes.io/default-container": "prometheus"

	storage: emptyDir: medium: "Memory"

	remoteWrite: [{
		url: "http://victoriametrics.monitoring.svc:8429/api/v1/write"
	}]

	// [=~"MonitorSelector"]: matchExpressions: [{key: "kube-prometheus-scrape", operator: "Exists"}]
	// remoteRead: [{url: "http://victoriametrics.monitoring.svc:8429/api/v1/read"}]
}

k: Ingress: "prometheus-k8s": {
	_authproxy: true
	spec: rules: [{
		http: paths: [{
			backend: service: {
				name: "prometheus-k8s"
				port: name: "web"
			}
		}]
	}]
}

// k: ClusterRole: "prometheus-k8s-namespaced": rules: k.Role."monitoring/prometheus-k8s".rules

// k: ClusterRoleBinding: "prometheus-k8s-namespaced": {
// 	roleRef: {
// 		apiGroup: "rbac.authorization.k8s.io"
// 		kind:     "ClusterRole"
// 		name:     k.ClusterRole."prometheus-k8s-namespaced".metadata.name
// 	}
// 	subjects: k.RoleBinding."monitoring/prometheus-k8s".subjects
// }

k: GrafanaDatasource: "prometheus": spec: datasource: {
	name:      "Prometheus"
	type:      "prometheus"
	url:       "http://prometheus-k8s.monitoring.svc:9090"
	access:    "proxy"
	isDefault: true
	basicAuth: false
	jsonData: {
		manageAlerts:   true
		prometheusType: "Prometheus"
	}
}

k: Alertmanager: "main": spec: {
	externalUrl: "https://alertmanager-main.addem.se"

	podMetadata: annotations: "kubectl.kubernetes.io/default-container": "alertmanager"
}

k: Ingress: "alertmanager-main": {
	_authproxy: true
	spec: rules: [{
		http: paths: [{
			backend: service: {
				name: "alertmanager-main"
				port: name: "web"
			}
		}]
	}]
}
