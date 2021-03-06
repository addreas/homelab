// Code generated by cue get go. DO NOT EDIT.

//cue:generate cue get go github.com/cilium/cilium/api/v1/models

package models

// BackendAddress Service backend address
//
// swagger:model BackendAddress
#BackendAddress: {
	// Layer 3 address
	// Required: true
	ip?: null | string @go(IP,*string)

	// Optional name of the node on which this backend runs
	nodeName?: string @go(NodeName)

	// Layer 4 port number
	port?: uint16 @go(Port)
}
