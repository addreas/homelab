// Code generated by cue get go. DO NOT EDIT.

//cue:generate cue get go github.com/cilium/cilium/api/v1/models

package models

// NameManager Internal state about DNS names in relation to policy subsystem
//
// swagger:model NameManager
#NameManager: {
	// Names to poll for DNS Poller
	DNSPollNames: [...string] @go(,[]string)

	// Mapping of FQDNSelectors to corresponding regular expressions
	FQDNPolicySelectors: [...null | #SelectorEntry] @go(,[]*SelectorEntry)
}
