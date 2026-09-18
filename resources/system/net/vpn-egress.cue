package kube

k: CiliumEgressGatewayPolicy: "vpn-egress": spec: {
	selectors: [{
		namespaceSelector: {}
		podSelector: matchLabels: "vpn-egress": "client"
	}]
	destinationCIDRs: ["0.0.0.0/0", "::/0"]
	excludedCIDRs: ["10.24.0.0/24", "10.48.0.0/16", "10.96.0.0/12"]
	egressGateway: {
		nodeSelector: matchExpressions: [{
			key:      "node-role.kubernetes.io/vpn-egress"
			operator: "Exists"
		}]
		interface: "eno1.25"
	}
}
