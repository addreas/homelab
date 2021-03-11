package kube

k: Service: hass2: {
	_selector: "app": "hass"
	spec: ports: [{
		name: "http"
		port: 8123
	}]
}

k: ServiceMonitor: hass: {
	_selector: "app": "hass"
	spec: endpoints: [{
		port:     "http"
		interval: "60s"
		path:     "/api/prometheus"
	}]
}
