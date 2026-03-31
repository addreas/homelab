package kube

k: Gateway: addem: {
	metadata: annotations: "cert-manager.io/cluster-issuer": "addem-se-letsencrypt"
	spec: {
		gatewayClassName: "cilium"
		infrastructure: labels: advertise: "arp"
		listeners: [{
			name:     "http"
			port:     80
			protocol: "HTTP"
			allowedRoutes: namespaces: from: "All"
		}, {
			name:     "https"
			hostname: "*.addem.se"
			port:     443
			protocol: "HTTPS"
			allowedRoutes: namespaces: from: "All"
			tls: {
				mode: "Terminate"
				certificateRefs: [{name: "addem-se-tls"}]
			}
		}]
	}
}
