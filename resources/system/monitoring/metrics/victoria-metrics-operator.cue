package kube

k: ServiceMonitor: "victoria-metrics-operator": {
	_selector: {
		"app.kubernetes.io/instance": "victoria-metrics-operator"
		"app.kubernetes.io/name":     "victoria-metrics-operator"
	}
	spec: endpoints: [{
		port:     "http"
		interval: "30s"
	}]
}
