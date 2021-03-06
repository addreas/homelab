// Code generated by cue get go. DO NOT EDIT.

//cue:generate cue get go github.com/cilium/cilium/api/v1/models

package models

// FrontendMapping Mapping of frontend to backend pods of an LRP
//
// swagger:model FrontendMapping
#FrontendMapping: {
	// Pod backends of an LRP
	backends: [...null | #LRPBackend] @go(Backends,[]*LRPBackend)

	// frontend address
	"frontend-address"?: null | #FrontendAddress @go(FrontendAddress,*FrontendAddress)
}
