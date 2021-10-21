package kube

import "encoding/yaml"

k: GitRepository: "kube-prometheus": spec: {
	interval: "1h"
	ref: branch: "main"
	url: "https://github.com/prometheus-operator/kube-prometheus"
	ignore: """
		/*
		!/manifests/setup/*monitor*
		!/manifests/setup/*probe*
		!/manifests/setup/*rule*
		!/manifests/kube*
		!/manifests/node*
		!/manifests/prometheus-adapter*
		!/manifests/grafana-dashboardDefinitions.yaml
		"""
}

k: Kustomization: "kube-prometheus-setup": spec: {
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
	patches: [{
		patch: yaml.Marshal({
			apiVersion: "apps/v1"
			kind:       "Deployment"
			metadata: {
				name:      "prometheus-adapter"
				namespace: "monitoring"
			}
			spec: template: spec: containers: [{
				name: "prometheus-adapter"
				args: [
					"--cert-dir=/var/run/serving-cert",
					"--config=/etc/adapter/config.yaml",
					"--logtostderr=true",
					"--metrics-relist-interval=1m",
					"--prometheus-url=http://vmsingle-main.monitoring.svc.cluster.local:8429/",
					"--secure-port=6443",
				]
			}]
		})
	}]
	prune: true
	sourceRef: {
		kind: "GitRepository"
		name: "kube-prometheus"
	}
}

let dashboards = [
	"alertmanager-overview",
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
