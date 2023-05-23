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

k: CiliumBGPPeeringPolicy: "main": spec: {
	nodeSelector: matchExpressions: [{key: "kubernetes.io/hostname", operator: "In", values: ["nucle1", "nucle2", "nucle3", "nucle4"]}]
	virtualRouters: [{
		localASN: 64512
		neighbors: [{
			peerAddress: "192.168.1.1/32"
			peerASN:     64512
		}]
		exportPodCIDR:   false
		serviceSelector: dummyMatch
	}]
}
