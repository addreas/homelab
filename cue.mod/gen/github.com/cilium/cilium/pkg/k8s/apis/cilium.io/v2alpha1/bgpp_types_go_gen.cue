// Code generated by cue get go. DO NOT EDIT.

//cue:generate cue get go github.com/cilium/cilium/pkg/k8s/apis/cilium.io/v2alpha1

package v2alpha1

import (
	metav1 "k8s.io/apimachinery/pkg/apis/meta/v1"
	slimv1 "github.com/cilium/cilium/pkg/k8s/slim/k8s/apis/meta/v1"
)

// CiliumBGPPeeringPolicy is a Kubernetes third-party resource for instructing
// Cilium's BGP control plane to create virtual BGP routers.
#CiliumBGPPeeringPolicy: {
	metav1.#TypeMeta

	// +deepequal-gen=false
	metadata: metav1.#ObjectMeta @go(ObjectMeta)

	// Spec is a human readable description of a BGP peering policy
	//
	// +kubebuilder:validation:Optional
	spec?: #CiliumBGPPeeringPolicySpec @go(Spec)
}

// CiliumBGPPeeringPolicyList is a list of
// CiliumBGPPeeringPolicy objects.
#CiliumBGPPeeringPolicyList: {
	metav1.#TypeMeta
	metadata: metav1.#ListMeta @go(ListMeta)

	// Items is a list of CiliumBGPPeeringPolicies.
	items: [...#CiliumBGPPeeringPolicy] @go(Items,[]CiliumBGPPeeringPolicy)
}

// CiliumBGPPeeringPolicySpec specifies one or more CiliumBGPVirtualRouter(s)
// to apply to nodes matching it's label selector.
#CiliumBGPPeeringPolicySpec: {
	// NodeSelector selects a group of nodes where this BGP Peering
	// Policy applies.
	//
	// If nil this policy applies to all nodes.
	//
	// +kubebuilder:validation:Optional
	nodeSelector?: null | slimv1.#LabelSelector @go(NodeSelector,*slimv1.LabelSelector)

	// A list of CiliumBGPVirtualRouter(s) which instructs
	// the BGP control plane how to instantiate virtual BGP routers.
	//
	// +kubebuilder:validation:Required
	// +kubebuilder:validation:MinItems=1
	virtualRouters: [...#CiliumBGPVirtualRouter] @go(VirtualRouters,[]CiliumBGPVirtualRouter)
}

// CiliumBGPNeighbor is a neighboring peer for use in a
// CiliumBGPVirtualRouter configuration.
#CiliumBGPNeighbor: {
	// PeerAddress is the IP address of the peer.
	// This must be in CIDR notation and use a /32 to express
	// a single host.
	//
	// +kubebuilder:validation:Required
	// +kubebuilder:validation:Format=cidr
	peerAddress: string @go(PeerAddress)

	// PeerASN is the ASN of the peer BGP router.
	// Supports extended 32bit ASNs
	//
	// +kubebuilder:validation:Required
	// +kubebuilder:validation:Minimum=0
	// +kubebuilder:validation:Maximum=4294967295
	peerASN: int @go(PeerASN)
}

// CiliumBGPVirtualRouter defines a discrete BGP virtual router configuration.
#CiliumBGPVirtualRouter: {
	// LocalASN is the ASN of this virtual router.
	// Supports extended 32bit ASNs
	//
	// +kubebuilder:validation:Required
	// +kubebuilder:validation:Minimum=0
	// +kubebuilder:validation:Maximum=4294967295
	localASN: int @go(LocalASN)

	// ExportPodCIDR determines whether to export the Node's private CIDR block
	// to the configured neighbors.
	//
	// +kubebuilder:validation:Optional
	exportPodCIDR: bool @go(ExportPodCIDR)

	// ServiceSelector selects a group of load balancer services which this
	// virtual router will announce.
	//
	// If nil no services will be announced.
	//
	// +kubebuilder:validation:Optional
	serviceSelector?: null | slimv1.#LabelSelector @go(ServiceSelector,*slimv1.LabelSelector)

	// Neighbors is a list of neighboring BGP peers for this virtual router
	//
	// +kubebuilder:validation:Required
	// +kubebuilder:validation:MinItems=1
	neighbors: [...#CiliumBGPNeighbor] @go(Neighbors,[]CiliumBGPNeighbor)
}