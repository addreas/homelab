package kube

k: GatewayClass: cilium: spec: {
	controllerName: "io.cilium/gateway-controller"
	parametersRef: {
		group:     "cilium.io"
		kind:      "CiliumGatewayClassConfig"
		name:      "cilium"
		namespace: "ingress"
	}
}

k: CiliumGatewayClassConfig: cilium: spec: telemetry: accessLogs: [{
	format: "JSON"
	json: {
		gateway:        "%CILIUM_GATEWAY_NAMESPACE%/%CILIUM_GATEWAY_NAME%"
		start_time:     "%START_TIME%"
		method:         "%REQUEST_HEADER(:METHOD)%"
		path:           "%REQUEST_HEADER(X-ENVOY-ORIGINAL-PATH?:PATH)%"
		protocol:       "%PROTOCOL%"
		response_code:  "%RESPONSE_CODE%"
		response_flags: "%RESPONSE_FLAGS%"
		bytes_received: "%BYTES_RECEIVED%"
		bytes_sent:     "%BYTES_SENT%"
		duration:       "%DURATION%"
		authority:      "%REQUEST_HEADER(:AUTHORITY)%"
		upstream_host:  "%UPSTREAM_HOST%"
	}
	targets: ["HTTP", "TCP"]
}]
