package kube

k: Service: "unifi-controller": {
	_selector: "app": "unifi-controller"
	spec: ports: [{
		name: "https"
		port: 8443
	}, {
		name: "metrics"
		port: 9130
	}]
}

k: ServiceMonitor: "unifi-controller": {
	_selector: "app": "unifi-controller"
	spec: endpoints: [{
		interval: "60s"
		port:     "metrics"
	}]
}
