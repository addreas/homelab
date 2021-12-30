package manifests

PodMonitor: "kube-proxy": {
	apiVersion: "monitoring.coreos.com/v1"
	kind:       "PodMonitor"
	metadata: {
		labels: {
			"app.kubernetes.io/name":    "kube-prometheus"
			"app.kubernetes.io/part-of": "kube-prometheus"
			"k8s-app":                   "kube-proxy"
		}
		name:      "kube-proxy"
		namespace: "monitoring"
	}
	spec: {
		jobLabel: "k8s-app"
		namespaceSelector: matchNames: [
			"kube-system",
		]
		podMetricsEndpoints: [{
			honorLabels: true
			relabelings: [{
				action:      "replace"
				regex:       "(.*)"
				replacement: "$1"
				sourceLabels: ["__meta_kubernetes_pod_node_name"]
				targetLabel: "instance"
			}]
			targetPort: 10249
		}]
		selector: matchLabels: "k8s-app": "kube-proxy"
	}
}
