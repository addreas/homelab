package kube

k: Namespace: monitoring: {}

k: GitRepository: "kube-prometheus": spec: {
	interval: "1h"
	ref: branch: "main"
	url: "https://github.com/prometheus-operator/kube-prometheus"
	ignore: """
		/*
		!/manifests/setup/
		!/manifests/alertmanager*
		!/manifests/kube*
		!/manifests/node*
		!/manifests/prometheus*
		!/manifests/grafana-dashboardDefinitions.yaml
		"""
}

k: Kustomization: "kube-prometheus-setup": spec: {
	healthChecks: [{
		kind:      "Deployment"
		name:      "prometheus-operator"
		namespace: "monitoring"
	}]
	interval: "30m"
	path:     "./manifests/setup"
	prune:    true
	sourceRef: {
		kind: "GitRepository"
		name: "kube-prometheus"
	}
}

k: Kustomization: "kube-prometheus": spec: {
	dependsOn: [{
		name: "kube-prometheus-setup"
	}]
	healthChecks: [{
		kind:      "StatefulSet"
		name:      "prometheus-k8s"
		namespace: "monitoring"
	}, {
		kind:      "StatefulSet"
		name:      "alertmanager-main"
		namespace: "monitoring"
	}, {
		kind:      "DaemonSet"
		name:      "node-exporter"
		namespace: "monitoring"
	}, {
		kind:      "Deployment"
		name:      "kube-state-metrics"
		namespace: "monitoring"
	}, {
		kind:      "Deployment"
		name:      "prometheus-adapter"
		namespace: "monitoring"
	}]
	interval: "30m"
	path:     "./manifests"
	patchesStrategicMerge: [{
		apiVersion: "monitoring.coreos.com/v1"
		kind:       "Prometheus"
		metadata: {
			name:      "k8s"
			namespace: "monitoring"
		}
		spec: {
			replicas:      2
			retentionSize: "4GB"
			storage: volumeClaimTemplate: {
				metadata: name: "data"
				spec: {
					resources: requests: storage: "5Gi"
					accessModes: ["ReadWriteOnce"]
				}
			}
		}
	}, {
		apiVersion: "monitoring.coreos.com/v1"
		kind:       "Alertmanager"
		metadata: {
			name:      "main"
			namespace: "monitoring"
		}
		spec: replicas: 1
	}]
	prune: true
	sourceRef: {
		kind: "GitRepository"
		name: "kube-prometheus"
	}
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
					name: "alertmanager-main"
					port: number: 9093
				}
			}]
		}]
	}
}


k: GrafanaDataSource: "prometheus": spec: {
	name: "prometheus.yaml"
	datasources: [{
		name:      "Prometheus"
		type:      "prometheus"
		url:       "http://prometheus-k8s.monitoring.svc:9090"
		access:    "proxy"
		isDefault: true
		editable:  false
	}]
}

let dashboards = [
	"apiserver",
	"cluster-total",
	"controller-manager",
	"k8s-resources-cluster",
	"k8s-resources-namespace",
	"k8s-resources-node",
	"k8s-resources-pod",
	"k8s-resources-workload",
	"k8s-resources-workloads-namespace",
	"kubelet",
	"namespace-by-pod",
	"namespace-by-workload",
	"node-cluster-rsrc-use",
	"node-rsrc-use",
	"nodes",
	"persistentvolumesusage",
	"pod-total",
	"prometheus",
	"prometheus-remote-write",
	"proxy",
	"scheduler",
	"statefulset",
	"workload-total",
]

k: GrafanaDashboard: {
	for dashboard in dashboards {
		"grafana-dashboard-\(dashboard)": spec: configMapRef: {
			name: "grafana-dashboard-\(dashboard)"
			key:  "\(dashboard).json"
		}
	}
}
