// Code generated by cue get go. DO NOT EDIT.

//cue:generate cue get go github.com/cilium/cilium/api/v1/models

package models

// BgpPeer State of a BGP Peer
//
// +k8s:deepcopy-gen=true
//
// swagger:model BgpPeer
#BgpPeer: {
	// BGP peer address family state
	families: [...null | #BgpPeerFamilies] @go(Families,[]*BgpPeerFamilies)

	// Local AS Number
	"local-asn"?: int64 @go(LocalAsn)

	// IP Address of peer
	"peer-address"?: string @go(PeerAddress)

	// Peer AS Number
	"peer-asn"?: int64 @go(PeerAsn)

	// BGP peer operational state as described here
	// https://www.rfc-editor.org/rfc/rfc4271#section-8.2.2
	//
	"session-state"?: string @go(SessionState)

	// BGP peer connection uptime in nano seconds.
	"uptime-nanoseconds"?: int64 @go(UptimeNanoseconds)
}