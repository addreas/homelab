package kube

k: CiliumLoadBalancerIPPool: "main": spec: {
	serviceSelector: matchExpressions: [{key: "dont-give-me-an-ip", operator: "DoesNotExist"}]
	blocks: [{
		cidr:  "10.0.2.0/24"
		start: "10.0.2.10"
		stop:  "10.0.2.25"
	}]
}

k: CiliumBGPClusterConfig: "cilium-bgp": spec: bgpInstances: [{
	name:     "main"
	localASN: 64512
	peers: [{
		name: "default"
		peerConfigRef: name: "cilium-peer"
		peerASN:     64512
		peerAddress: "10.0.2.1"
	}]
}]

k: CiliumBGPPeerConfig: "cilium-peer": spec: families: [{
	afi:  "ipv4"
	safi: "unicast"
	advertisements: matchLabels: advertise: "bgp"
}]

k: CiliumBGPAdvertisement: "bgp-loadbalancer-services": {
	metadata: labels: advertise: "bgp"
	spec: advertisements: [{
		advertisementType: "Service"
		service: addresses: ["LoadBalancerIP"]
		selector: matchLabels: advertise: "bgp"
	}]
}

k: CiliumL2AnnouncementPolicy: "arp-loadbalancer-services": spec: {
	serviceSelector: matchLabels: advertise: "arp"
	interfaces: ["^eno[0-9]+"]
	loadBalancerIPs: true
}
