// Code generated by cue get go. DO NOT EDIT.

//cue:generate cue get go github.com/cilium/cilium/api/v1/models

package models

// MessageForwardingStatistics Statistics of a message forwarding entity
//
// swagger:model MessageForwardingStatistics
#MessageForwardingStatistics: {
	// Number of messages denied
	denied?: int64 @go(Denied)

	// Number of errors while parsing messages
	error?: int64 @go(Error)

	// Number of messages forwarded
	forwarded?: int64 @go(Forwarded)

	// Number of messages received
	received?: int64 @go(Received)
}