// Code generated by cue get go. DO NOT EDIT.

//cue:generate cue get go github.com/cilium/cilium/api/v1/models

package models

// BgpRoute Single BGP route retrieved from the RIB of underlying router
//
// swagger:model BgpRoute
#BgpRoute: {
	// IP address specifying a BGP neighbor if the source table type is adj-rib-in or adj-rib-out
	neighbor?: string @go(Neighbor)

	// List of routing paths leading towards the prefix
	paths: [...null | #BgpPath] @go(Paths,[]*BgpPath)

	// IP prefix of the route
	prefix?: string @go(Prefix)

	// Autonomous System Number (ASN) identifying a BGP virtual router instance
	"router-asn"?: int64 @go(RouterAsn)
}