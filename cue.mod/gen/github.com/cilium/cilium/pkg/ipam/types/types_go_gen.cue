// Code generated by cue get go. DO NOT EDIT.

//cue:generate cue get go github.com/cilium/cilium/pkg/ipam/types --exclude=HubbleStatus$,ControllerStatus(es)?$,ControllerList$,StatusResponse$,DebugInfo$,Endpoint(Status)?(Slice)?(List)?$

package types

import "github.com/cilium/cilium/pkg/cidr"

// Limits specifies the IPAM relevant instance limits
#Limits: {
	// Adapters specifies the maximum number of interfaces that can be
	// attached to the instance
	Adapters: int

	// IPv4 is the maximum number of IPv4 addresses per adapter/interface
	IPv4: int

	// IPv6 is the maximum number of IPv6 addresses per adapter/interface
	IPv6: int

	// HypervisorType tracks the instance's hypervisor type if available. Used to determine if features like prefix
	// delegation are supported on an instance. Bare metal instances would have empty string.
	HypervisorType: string
}

// AllocationIP is an IP which is available for allocation, or already
// has been allocated
#AllocationIP: {
	// Owner is the owner of the IP. This field is set if the IP has been
	// allocated. It will be set to the pod name or another identifier
	// representing the usage of the IP
	//
	// The owner field is left blank for an entry in Spec.IPAM.Pool and
	// filled out as the IP is used and also added to Status.IPAM.Used.
	//
	// +optional
	owner?: string @go(Owner)

	// Resource is set for both available and allocated IPs, it represents
	// what resource the IP is associated with, e.g. in combination with
	// AWS ENI, this will refer to the ID of the ENI
	//
	// +optional
	resource?: string @go(Resource)
}

// AllocationMap is a map of allocated IPs indexed by IP
#AllocationMap: {[string]: #AllocationIP}

// IPAMPodCIDR is a pod CIDR
//
// +kubebuilder:validation:Format=cidr
#IPAMPodCIDR: string

// IPAMPoolAllocation describes an allocation of an IPAM pool from the operator to the
// node. It contains the assigned PodCIDRs allocated from this pool
#IPAMPoolAllocation: {
	// Pool is the name of the IPAM pool backing this allocation
	//
	// +kubebuilder:validation:MinLength=1
	pool: string @go(Pool)

	// CIDRs contains a list of pod CIDRs currently allocated from this pool
	//
	// +optional
	cidrs?: [...#IPAMPodCIDR] @go(CIDRs,[]IPAMPodCIDR)
}

#IPAMPoolRequest: {
	// Pool is the name of the IPAM pool backing this request
	//
	// +kubebuilder:validation:MinLength=1
	pool: string @go(Pool)

	// Needed indicates how many IPs out of the above Pool this node requests
	// from the operator. The operator runs a reconciliation loop to ensure each
	// node always has enough PodCIDRs allocated in each pool to fulfill the
	// requested number of IPs here.
	//
	// +optional
	needed?: #IPAMPoolDemand @go(Needed)
}

#IPAMPoolSpec: {
	// Requested contains a list of IPAM pool requests, i.e. indicates how many
	// addresses this node requests out of each pool listed here. This field
	// is owned and written to by cilium-agent and read by the operator.
	//
	// +optional
	requested?: [...#IPAMPoolRequest] @go(Requested,[]IPAMPoolRequest)

	// Allocated contains the list of pooled CIDR assigned to this node. The
	// operator will add new pod CIDRs to this field, whereas the agent will
	// remove CIDRs it has released.
	//
	// +optional
	allocated?: [...#IPAMPoolAllocation] @go(Allocated,[]IPAMPoolAllocation)
}

// IPAMSpec is the IPAM specification of the node
//
// This structure is embedded into v2.CiliumNode
#IPAMSpec: {
	// Pool is the list of IPv4 addresses available to the node for allocation.
	// When an IPv4 address is used, it will remain on this list but will be added to
	// Status.IPAM.Used
	//
	// +optional
	pool?: #AllocationMap @go(Pool)

	// IPv6Pool is the list of IPv6 addresses available to the node for allocation.
	// When an IPv6 address is used, it will remain on this list but will be added to
	// Status.IPAM.IPv6Used
	//
	// +optional
	"ipv6-pool"?: #AllocationMap @go(IPv6Pool)

	// Pools contains the list of assigned IPAM pools for this node.
	//
	// +optional
	pools?: #IPAMPoolSpec @go(Pools)

	// PodCIDRs is the list of CIDRs available to the node for allocation.
	// When an IP is used, the IP will be added to Status.IPAM.Used
	//
	// +optional
	podCIDRs?: [...string] @go(PodCIDRs,[]string)

	// MinAllocate is the minimum number of IPs that must be allocated when
	// the node is first bootstrapped. It defines the minimum base socket
	// of addresses that must be available. After reaching this watermark,
	// the PreAllocate and MaxAboveWatermark logic takes over to continue
	// allocating IPs.
	//
	// +kubebuilder:validation:Minimum=0
	"min-allocate"?: int @go(MinAllocate)

	// MaxAllocate is the maximum number of IPs that can be allocated to the
	// node. When the current amount of allocated IPs will approach this value,
	// the considered value for PreAllocate will decrease down to 0 in order to
	// not attempt to allocate more addresses than defined.
	//
	// +kubebuilder:validation:Minimum=0
	"max-allocate"?: int @go(MaxAllocate)

	// PreAllocate defines the number of IP addresses that must be
	// available for allocation in the IPAMspec. It defines the buffer of
	// addresses available immediately without requiring cilium-operator to
	// get involved.
	//
	// +kubebuilder:validation:Minimum=0
	"pre-allocate"?: int @go(PreAllocate)

	// MaxAboveWatermark is the maximum number of addresses to allocate
	// beyond the addresses needed to reach the PreAllocate watermark.
	// Going above the watermark can help reduce the number of API calls to
	// allocate IPs, e.g. when a new ENI is allocated, as many secondary
	// IPs as possible are allocated. Limiting the amount can help reduce
	// waste of IPs.
	//
	// +kubebuilder:validation:Minimum=0
	"max-above-watermark"?: int @go(MaxAboveWatermark)

	// StaticIPTags are used to determine the pool of IPs from which to
	// attribute a static IP to the node. For example in AWS this is used to
	// filter Elastic IP Addresses.
	//
	// +optional
	"static-ip-tags"?: {[string]: string} @go(StaticIPTags,map[string]string)
}

// IPReleaseStatus defines the valid states in IP release handshake
//
// +kubebuilder:validation:Enum=marked-for-release;ready-for-release;do-not-release;released
#IPReleaseStatus: string

// IPAMStatus is the IPAM status of a node
//
// This structure is embedded into v2.CiliumNode
#IPAMStatus: {
	// Used lists all IPv4 addresses out of Spec.IPAM.Pool which have been allocated
	// and are in use.
	//
	// +optional
	used?: #AllocationMap @go(Used)

	// IPv6Used lists all IPv6 addresses out of Spec.IPAM.IPv6Pool which have been
	// allocated and are in use.
	//
	// +optional
	"ipv6-used"?: #AllocationMap @go(IPv6Used)

	// PodCIDRs lists the status of each pod CIDR allocated to this node.
	//
	// +optional
	"pod-cidrs"?: #PodCIDRMap @go(PodCIDRs)

	// Operator is the Operator status of the node
	//
	// +optional
	"operator-status"?: #OperatorStatus @go(OperatorStatus)

	// ReleaseIPs tracks the state for every IPv4 address considered for release.
	// The value can be one of the following strings:
	// * marked-for-release : Set by operator as possible candidate for IP
	// * ready-for-release  : Acknowledged as safe to release by agent
	// * do-not-release     : IP already in use / not owned by the node. Set by agent
	// * released           : IP successfully released. Set by operator
	//
	// +optional
	"release-ips"?: {[string]: #IPReleaseStatus} @go(ReleaseIPs,map[string]IPReleaseStatus)

	// ReleaseIPv6s tracks the state for every IPv6 address considered for release.
	// The value can be one of the following strings:
	// * marked-for-release : Set by operator as possible candidate for IP
	// * ready-for-release  : Acknowledged as safe to release by agent
	// * do-not-release     : IP already in use / not owned by the node. Set by agent
	// * released           : IP successfully released. Set by operator
	//
	// +optional
	"release-ipv6s"?: {[string]: #IPReleaseStatus} @go(ReleaseIPv6s,map[string]IPReleaseStatus)

	// AssignedStaticIP is the static IP assigned to the node (ex: public Elastic IP address in AWS)
	//
	// +optional
	"assigned-static-ip"?: string @go(AssignedStaticIP)
}

// IPAMPoolRequest is a request from the agent to the operator, indicating how
// may IPs it requires from a given pool
#IPAMPoolDemand: {
	// IPv4Addrs contains the number of requested IPv4 addresses out of a given
	// pool
	//
	// +optional
	"ipv4-addrs"?: int @go(IPv4Addrs)

	// IPv6Addrs contains the number of requested IPv6 addresses out of a given
	// pool
	//
	// +optional
	"ipv6-addrs"?: int @go(IPv6Addrs)
}

#PodCIDRMap: [string]: #PodCIDRMapEntry

// +kubebuilder:validation:Enum=released;depleted;in-use
#PodCIDRStatus: string // #enumPodCIDRStatus

#enumPodCIDRStatus:
	#PodCIDRStatusReleased |
	#PodCIDRStatusDepleted |
	#PodCIDRStatusInUse

#PodCIDRStatusReleased: #PodCIDRStatus & "released"
#PodCIDRStatusDepleted: #PodCIDRStatus & "depleted"
#PodCIDRStatusInUse:    #PodCIDRStatus & "in-use"

#PodCIDRMapEntry: {
	// Status describes the status of a pod CIDR
	//
	// +optional
	status?: #PodCIDRStatus @go(Status)
}

// OperatorStatus is the status used by cilium-operator to report
// errors in case the allocation CIDR failed.
#OperatorStatus: {
	// Error is the error message set by cilium-operator.
	//
	// +optional
	error?: string @go(Error)
}

// Tags implements generic key value tags
#Tags: {[string]: string}

// Subnet is a representation of a subnet
#Subnet: {
	// ID is the subnet ID
	ID: string

	// Name is the subnet name
	Name: string

	// CIDR is the IPv4 CIDR associated with the subnet
	CIDR?: null | cidr.#CIDR @go(,*cidr.CIDR)

	// IPv6CIDR is the IPv6 CIDR associated with the subnet
	IPv6CIDR?: null | cidr.#CIDR @go(,*cidr.CIDR)

	// AvailabilityZone is the availability zone of the subnet
	AvailabilityZone: string

	// VirtualNetworkID is the virtual network the subnet is in
	VirtualNetworkID: string

	// AvailableAddresses is the number of IPv4 addresses available for
	// allocation
	AvailableAddresses: int

	// AvailableIPv6Addresses is the number of IPv6 addresses available for
	// allocation
	AvailableIPv6Addresses: int

	// Tags is the tags of the subnet
	Tags: #Tags
}

// SubnetMap indexes subnets by subnet ID
#SubnetMap: {[string]: null | #Subnet}

// VirtualNetwork is the representation of a virtual network
#VirtualNetwork: {
	// ID is the ID of the virtual network
	ID: string

	// PrimaryCIDR is the primary IPv4 CIDR
	PrimaryCIDR: string

	// CIDRs is the list of secondary IPv4 CIDR ranges associated with the VPC
	CIDRs: [...string] @go(,[]string)

	// IPv6CIDRs is the list of IPv6 CIDR ranges associated with the VPC
	IPv6CIDRs: [...string] @go(,[]string)
}

// VirtualNetworkMap indexes virtual networks by their ID
#VirtualNetworkMap: {[string]: null | #VirtualNetwork}

#PoolNotExists: #PoolID & ""

#PoolUnspec: #PoolID & ""

// PoolID is the type used to identify an IPAM pool
#PoolID: string // #enumPoolID

#enumPoolID:
	#PoolNotExists |
	#PoolUnspec

// PoolQuota defines the limits of an IPAM pool
#PoolQuota: {
	// AvailabilityZone is the availability zone in which the IPAM pool resides in
	AvailabilityZone: string

	// AvailableIPs is the number of available IPs in the pool
	AvailableIPs: int

	// AvailableIPv6s is the number of available IPv6 addresses in the pool
	AvailableIPv6s: int
}

// PoolQuotaMap is a map of pool quotas indexes by pool identifier
#PoolQuotaMap: {[string]: #PoolQuota}

// Interface is the implementation of a IPAM relevant network interface
// +k8s:deepcopy-gen=false
// +deepequal-gen=false
#Interface: _

// InterfaceRevision is the configurationr revision of a network interface. It
// consists of a revision hash representing the current configuration version
// and the resource itself.
//
// +k8s:deepcopy-gen=false
// +deepequal-gen=false
#InterfaceRevision: {
	// Resource is the interface resource
	Resource: #Interface

	// Fingerprint is the fingerprint reprsenting the network interface
	// configuration. It is typically implemented as the result of a hash
	// function calculated off the resource. This field is optional, not
	// all IPAM backends make use of fingerprints.
	Fingerprint: string
}

// Instance is the representation of an instance, typically a VM, subject to
// per-node IPAM logic
//
// +k8s:deepcopy-gen=false
// +deepequal-gen=false
#Instance: {
	// interfaces is a map of all interfaces attached to the instance
	// indexed by the interface ID
	Interfaces: {[string]: #InterfaceRevision} @go(,map[string]InterfaceRevision)
}

#Address: _
