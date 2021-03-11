package kube

k: Service: bitwarden: {
	_selector: "app": "bitwarden"
	spec: {
		ports: [{
			name: "http"
			port: 8080
		}, {
			name: "websocket"
			port: 3012
		}]
	}
}
