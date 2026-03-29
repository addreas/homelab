@if(bgp)
package kube

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
