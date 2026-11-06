package kube

k: PodMonitor: "cloudnative-pg": {
	_selector: "app.kubernetes.io/name": "cloudnative-pg"
	spec: podMetricsEndpoints: [{
		port:     "metrics"
		interval: "30s"
	}]
}

k: PodMonitor: "cnpg-instances": {
	_selector: "cnpg.io/podRole": "instance"
	spec: {
		namespaceSelector: any: true
		podMetricsEndpoints: [{
			port:        "metrics"
			interval:    "30s"
			honorLabels: true
		}]
	}
}

k: GrafanaDashboard: "cloudnative-pg": spec: grafanaCom: id: 20417

k: GitRepository: "cnpg-monitoring": spec: {
	url: "https://github.com/cloudnative-pg/cloudnative-pg"
	ref: tag: "v1.30.1"
	ignore: """
		/*
		!/docs/src/samples/monitoring/prometheusrule.yaml
		"""
}

k: Kustomization: "cnpg-monitoring": spec: {
	path:            "docs/src/samples/monitoring"
	targetNamespace: "cnpg-system"
	patches: [{
		target: kind: "PrometheusRule"
		patch: """
			- op: add
			  path: /metadata/labels
			  value:
			    role: alert-rules
			    ruler: metrics
			"""
	}]
}
