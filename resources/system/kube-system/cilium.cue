package kube

let dummyMatch = {
	matchExpressions: [{key: "dummy", operator: "NotIn", values: ["anything"]}]
}

k: CiliumLoadBalancerIPPool: "main": spec: {
	blocks: [{
		cidr: "192.168.10.0/24"
	}]
	serviceSelector: dummyMatch
	disabled:        false
}

k: CiliumBGPPeeringPolicy: "main": spec: {
	nodeSelector: dummyMatch
	virtualRouters: [{
		localASN: 64512
		neighbors: [{
			peerASN:     64512
			peerAddress: "192.168.0.1/32"
		}]
		serviceSelector: dummyMatch
		exportPodCIDR:   false
	}]
}
