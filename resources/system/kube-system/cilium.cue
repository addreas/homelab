package kube

let dummyMatch = {
	matchExpressions: [{key: "dummy", operator: "NotIn", values: ["anything"]}]
}

k: CiliumLoadBalancerIPPool: "main": spec: {
	cidrs: [{
		cidr: "192.168.10.0/24"
	}]
	serviceSelector: dummyMatch
	disabled:        false
}

k: CiliumL2AnnouncementPolicy: "main": spec: {
	nodeSelector:    dummyMatch
	serviceSelector: dummyMatch
	interfaces: ["eno1"]
	externalIPs:     true
	loadBalancerIPs: true
}
