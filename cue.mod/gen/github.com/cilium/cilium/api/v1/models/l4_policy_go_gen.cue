// Code generated by cue get go. DO NOT EDIT.

//cue:generate cue get go github.com/cilium/cilium/api/v1/models

package models

// L4Policy L4 endpoint policy
//
// +k8s:deepcopy-gen=true
//
// swagger:model L4Policy
#L4Policy: {
	// List of L4 egress rules
	egress: [...null | #PolicyRule] @go(Egress,[]*PolicyRule)

	// List of L4 ingress rules
	ingress: [...null | #PolicyRule] @go(Ingress,[]*PolicyRule)
}
