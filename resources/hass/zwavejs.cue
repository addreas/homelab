package kube

k: Deployment: "hass-zwavejs": {
	spec: template: spec: containers: [{
		name:  "zwavejs"
		image: "kpine/zwave-js-server:latest"
		ports: [{containerPort: 3000}]
		env: [{
			name: "NETWORK_KEY"
			valueFrom: secretKeyRef: {
				name: "zwave-network-key"
				key:  "key"
			}
		}, {
			name:  "USB_PATH"
			value: "/dev/aeotec-z-stick"
		}, {
			name:  "LOGLEVEL"
			value: "info"
		}]
		resources: limits: "addem.se/dev_aeotec_zstick": "1"
	}]
}

k: Service: "hass-zwavejs": {
	_selector: app: "hass-zwavejs"
	spec: ports: [{
		port: 3000
	}]
}