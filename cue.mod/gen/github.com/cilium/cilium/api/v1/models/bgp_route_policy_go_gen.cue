// Code generated by cue get go. DO NOT EDIT.

//cue:generate cue get go github.com/cilium/cilium/api/v1/models

package models

// BgpRoutePolicy Single BGP route policy retrieved from the underlying router
//
// swagger:model BgpRoutePolicy
#BgpRoutePolicy: {
	// Name of the route policy
	name?: string @go(Name)

	// Autonomous System Number (ASN) identifying a BGP virtual router instance
	"router-asn"?: int64 @go(RouterAsn)

	// List of the route policy statements
	statements: [...null | #BgpRoutePolicyStatement] @go(Statements,[]*BgpRoutePolicyStatement)

	// Type of the route policy
	// Enum: [export import]
	type?: string @go(Type)
}

// BgpRoutePolicyTypeExport captures enum value "export"
#BgpRoutePolicyTypeExport: "export"

// BgpRoutePolicyTypeImport captures enum value "import"
#BgpRoutePolicyTypeImport: "import"
