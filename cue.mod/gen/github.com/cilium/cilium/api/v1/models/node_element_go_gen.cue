// Code generated by cue get go. DO NOT EDIT.

//cue:generate cue get go github.com/cilium/cilium/api/v1/models

package models

// NodeElement Known node in the cluster
//
// +k8s:deepcopy-gen=true
//
// swagger:model NodeElement
#NodeElement: {
	// Address used for probing cluster connectivity
	"health-endpoint-address"?: null | #NodeAddressing @go(HealthEndpointAddress,*NodeAddressing)

	// Source address for Ingress listener
	"ingress-address"?: null | #NodeAddressing @go(IngressAddress,*NodeAddressing)

	// Name of the node including the cluster association. This is typically
	// <clustername>/<hostname>.
	//
	name?: string @go(Name)

	// Primary address used for intra-cluster communication
	"primary-address"?: null | #NodeAddressing @go(PrimaryAddress,*NodeAddressing)

	// Alternative addresses assigned to the node
	"secondary-addresses": [...null | #NodeAddressingElement] @go(SecondaryAddresses,[]*NodeAddressingElement)

	// Source of the node configuration
	source?: string @go(Source)
}
