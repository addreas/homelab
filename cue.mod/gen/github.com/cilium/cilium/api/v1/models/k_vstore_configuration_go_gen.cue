// Code generated by cue get go. DO NOT EDIT.

//cue:generate cue get go github.com/cilium/cilium/api/v1/models

package models

// KVstoreConfiguration Configuration used for the kvstore
//
// swagger:model KVstoreConfiguration
#KVstoreConfiguration: {
	// Configuration options
	options?: {[string]: string} @go(Options,map[string]string)

	// Type of kvstore
	type?: string @go(Type)
}
