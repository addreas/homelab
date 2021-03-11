package kube

k: Namespace: monitoring: {}

k: GitRepository: "kube-prometheus": spec: {
	interval: "1h"
	ref: branch: "main"
	url: "https://github.com/prometheus-operator/kube-prometheus"
	ignore: """
		./manifests/grafana*
		./manifests/blackbox*
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
		apiVersion: "v1"
		kind:       "ConfigMap"
		metadata: {
			name:      "grafana-dashboard-apiserver"
			namespace: "monitoring"
			labels: grafana_dashboard: "kube-prometheus"
		}
	}, {
		apiVersion: "v1"
		kind:       "ConfigMap"
		metadata: {
			name:      "grafana-dashboard-cluster-total"
			namespace: "monitoring"
			labels: grafana_dashboard: "kube-prometheus"
		}
	}, {
		apiVersion: "v1"
		kind:       "ConfigMap"
		metadata: {
			name:      "grafana-dashboard-controller-manager"
			namespace: "monitoring"
			labels: grafana_dashboard: "kube-prometheus"
		}
	}, {
		apiVersion: "v1"
		kind:       "ConfigMap"
		metadata: {
			name:      "grafana-dashboard-k8s-resources-cluster"
			namespace: "monitoring"
			labels: grafana_dashboard: "kube-prometheus"
		}
	}, {
		apiVersion: "v1"
		kind:       "ConfigMap"
		metadata: {
			name:      "grafana-dashboard-k8s-resources-namespace"
			namespace: "monitoring"
			labels: grafana_dashboard: "kube-prometheus"
		}
	}, {
		apiVersion: "v1"
		kind:       "ConfigMap"
		metadata: {
			name:      "grafana-dashboard-k8s-resources-node"
			namespace: "monitoring"
			labels: grafana_dashboard: "kube-prometheus"
		}
	}, {
		apiVersion: "v1"
		kind:       "ConfigMap"
		metadata: {
			name:      "grafana-dashboard-k8s-resources-pod"
			namespace: "monitoring"
			labels: grafana_dashboard: "kube-prometheus"
		}
	}, {
		apiVersion: "v1"
		kind:       "ConfigMap"
		metadata: {
			name:      "grafana-dashboard-k8s-resources-workload"
			namespace: "monitoring"
			labels: grafana_dashboard: "kube-prometheus"
		}
	}, {
		apiVersion: "v1"
		kind:       "ConfigMap"
		metadata: {
			name:      "grafana-dashboard-k8s-resources-workloads-namespace"
			namespace: "monitoring"
			labels: grafana_dashboard: "kube-prometheus"
		}
	}, {
		apiVersion: "v1"
		kind:       "ConfigMap"
		metadata: {
			name:      "grafana-dashboard-kubelet"
			namespace: "monitoring"
			labels: grafana_dashboard: "kube-prometheus"
		}
	}, {
		apiVersion: "v1"
		kind:       "ConfigMap"
		metadata: {
			name:      "grafana-dashboard-namespace-by-pod"
			namespace: "monitoring"
			labels: grafana_dashboard: "kube-prometheus"
		}
	}, {
		apiVersion: "v1"
		kind:       "ConfigMap"
		metadata: {
			name:      "grafana-dashboard-namespace-by-workload"
			namespace: "monitoring"
			labels: grafana_dashboard: "kube-prometheus"
		}
	}, {
		apiVersion: "v1"
		kind:       "ConfigMap"
		metadata: {
			name:      "grafana-dashboard-node-cluster-rsrc-use"
			namespace: "monitoring"
			labels: grafana_dashboard: "kube-prometheus"
		}
	}, {
		apiVersion: "v1"
		kind:       "ConfigMap"
		metadata: {
			name:      "grafana-dashboard-node-rsrc-use"
			namespace: "monitoring"
			labels: grafana_dashboard: "kube-prometheus"
		}
	}, {
		apiVersion: "v1"
		kind:       "ConfigMap"
		metadata: {
			name:      "grafana-dashboard-nodes"
			namespace: "monitoring"
			labels: grafana_dashboard: "kube-prometheus"
		}
	}, {
		apiVersion: "v1"
		kind:       "ConfigMap"
		metadata: {
			name:      "grafana-dashboard-persistentvolumesusage"
			namespace: "monitoring"
			labels: grafana_dashboard: "kube-prometheus"
		}
	}, {
		apiVersion: "v1"
		kind:       "ConfigMap"
		metadata: {
			name:      "grafana-dashboard-pod-total"
			namespace: "monitoring"
			labels: grafana_dashboard: "kube-prometheus"
		}
	}, {
		apiVersion: "v1"
		kind:       "ConfigMap"
		metadata: {
			name:      "grafana-dashboard-prometheus"
			namespace: "monitoring"
			labels: grafana_dashboard: "kube-prometheus"
		}
	}, {
		apiVersion: "v1"
		kind:       "ConfigMap"
		metadata: {
			name:      "grafana-dashboard-prometheus-remote-write"
			namespace: "monitoring"
			labels: grafana_dashboard: "kube-prometheus"
		}
	}, {
		apiVersion: "v1"
		kind:       "ConfigMap"
		metadata: {
			name:      "grafana-dashboard-proxy"
			namespace: "monitoring"
			labels: grafana_dashboard: "kube-prometheus"
		}
	}, {
		apiVersion: "v1"
		kind:       "ConfigMap"
		metadata: {
			name:      "grafana-dashboard-scheduler"
			namespace: "monitoring"
			labels: grafana_dashboard: "kube-prometheus"
		}
	}, {
		apiVersion: "v1"
		kind:       "ConfigMap"
		metadata: {
			name:      "grafana-dashboard-statefulset"
			namespace: "monitoring"
			labels: grafana_dashboard: "kube-prometheus"
		}
	}, {
		apiVersion: "v1"
		kind:       "ConfigMap"
		metadata: {
			name:      "grafana-dashboard-workload-total"
			namespace: "monitoring"
			labels: grafana_dashboard: "kube-prometheus"
		}
	}, {
		apiVersion: "monitoring.coreos.com/v1"
		kind:       "Prometheus"
		metadata: {
			name:      "k8s"
			namespace: "monitoring"
		}
		spec: {
			retentionSize: "4GB"
			storage: volumeClaimTemplate: {
				metadata: name: "data"
				spec: {
					resources: requests: storage: "5Gi"
					accessModes: ["ReadWriteOnce"]
				}
			}
		}
	}]
	prune: true
	sourceRef: {
		kind: "GitRepository"
		name: "kube-prometheus"
	}
}

k: Service: "kube-scheduler": {
	metadata: {
		labels: {
			"app.kubernetes.io/name": "kube-scheduler"
			"k8s-app":                "kube-scheduler"
		}
		namespace: "kube-system"
	}
	spec: {
		selector: {
			component: "kube-scheduler"
			tier:      "control-plane"
		}
		ports: [{
			name: "https-metrics"
			port: 10259
		}]
	}
}
k: Service: "kube-controller-manager": {
	metadata: {
		labels: {
			"app.kubernetes.io/name": "kube-controller-manager"
			"k8s-app":                "kube-controller-manager"
		}
		namespace: "kube-system"
	}
	spec: {
		selector: {
			component: "kube-controller-manager"
			tier:      "control-plane"
		}
		ports: [{
			name: "https-metrics"
			port: 10257
		}]
	}
}
