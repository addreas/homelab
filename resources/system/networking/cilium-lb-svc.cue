package kube

k: CiliumLoadBalancerIPPool: "main": spec: {
	serviceSelector: matchExpressions: [{key: "dont-give-me-an-ip", operator: "DoesNotExist"}]
	blocks: [{
		start: "10.24.0.10"
		stop:  "10.24.0.25"
	}]
}

k: CiliumL2AnnouncementPolicy: "arp-loadbalancer-services": spec: {
	serviceSelector: matchLabels: advertise: "arp"
	interfaces: ["^eno[0-9]+"]
	loadBalancerIPs: true
}
