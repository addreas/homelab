package v2

import (
	"strings"
	"time"
)

#CiliumBGPPeerConfig: {
	_embeddedResource

	// APIVersion defines the versioned schema of this representation
	// of an object.
	// Servers should convert recognized schemas to the latest
	// internal value, and
	// may reject unrecognized values.
	// More info:
	// https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#resources
	apiVersion?: string

	// Kind is a string value representing the REST resource this
	// object represents.
	// Servers may infer this from the endpoint the client submits
	// requests to.
	// Cannot be updated.
	// In CamelCase.
	// More info:
	// https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#types-kinds
	kind?: string
	metadata!: {}

	// Spec is the specification of the desired behavior of the
	// CiliumBGPPeerConfig.
	spec!: {
		// AuthSecretRef is the name of the secret to use to fetch a TCP
		// authentication password for this peer.
		//
		// If not specified, no authentication is used.
		authSecretRef?: string

		// EBGPMultihopTTL controls the multi-hop feature for eBGP peers.
		// Its value defines the Time To Live (TTL) value used in BGP
		// packets sent to the peer.
		//
		// If not specified, EBGP multihop is disabled. This field is
		// ignored for iBGP neighbors.
		ebgpMultihop?: int32 & int & <=255 & >=1

		// Families, if provided, defines a set of AFI/SAFIs the speaker
		// will
		// negotiate with it's peer.
		//
		// If not specified, the default families of IPv6/unicast and
		// IPv4/unicast will be created.
		families?: [...{
			// Advertisements selects group of BGP Advertisement(s) to
			// advertise for this family.
			//
			// If not specified, no advertisements are sent for this family.
			//
			// This field is ignored in CiliumBGPNeighbor which is used in
			// CiliumBGPPeeringPolicy.
			// Use CiliumBGPPeeringPolicy advertisement options instead.
			advertisements?: {
				// matchExpressions is a list of label selector requirements. The
				// requirements are ANDed.
				matchExpressions?: [...{
					// key is the label key that the selector applies to.
					key!: string

					// operator represents a key's relationship to a set of values.
					// Valid operators are In, NotIn, Exists and DoesNotExist.
					operator!: "In" | "NotIn" | "Exists" | "DoesNotExist"

					// values is an array of string values. If the operator is In or
					// NotIn,
					// the values array must be non-empty. If the operator is Exists
					// or DoesNotExist,
					// the values array must be empty. This array is replaced during a
					// strategic
					// merge patch.
					values?: [...string]
				}]

				// matchLabels is a map of {key,value} pairs. A single {key,value}
				// in the matchLabels
				// map is equivalent to an element of matchExpressions, whose key
				// field is "key", the
				// operator is "In", and the values array contains only "value".
				// The requirements are ANDed.
				matchLabels?: [string]: strings.MaxRunes(
							63) & =~"^(([A-Za-z0-9][-A-Za-z0-9_.]*)?[A-Za-z0-9])?$"
			}

			// Afi is the Address Family Identifier (AFI) of the family.
			afi!: "ipv4" | "ipv6" | "l2vpn" | "ls" | "opaque"

			// Safi is the Subsequent Address Family Identifier (SAFI) of the
			// family.
			safi!: "unicast" | "multicast" | "mpls_label" | "encapsulation" | "vpls" | "evpn" | "ls" | "sr_policy" | "mup" | "mpls_vpn" | "mpls_vpn_multicast" | "route_target_constraints" | "flowspec_unicast" | "flowspec_vpn" | "key_value"
		}]

		// GracefulRestart defines graceful restart parameters which are
		// negotiated
		// with this peer.
		//
		// If not specified, the graceful restart capability is disabled.
		gracefulRestart?: {
			// Enabled flag, when set enables graceful restart capability.
			enabled!: bool

			// RestartTimeSeconds is the estimated time it will take for the
			// BGP
			// session to be re-established with peer after a restart.
			// After this period, peer will remove stale routes. This is
			// described RFC 4724 section 4.2.
			restartTimeSeconds?: int32 & int & <=4095 & >=1
		}

		// Timers defines the BGP timers for the peer.
		//
		// If not specified, the default timers are used.
		timers?: {
			// ConnectRetryTimeSeconds defines the initial value for the BGP
			// ConnectRetryTimer (RFC 4271, Section 8).
			//
			// If not specified, defaults to 120 seconds.
			connectRetryTimeSeconds?: int32 & int & <=2147483647 & >=1

			// HoldTimeSeconds defines the initial value for the BGP HoldTimer
			// (RFC 4271, Section 4.2).
			// Updating this value will cause a session reset.
			//
			// If not specified, defaults to 90 seconds.
			holdTimeSeconds?: int32 & int & <=65535 & >=3

			// KeepaliveTimeSeconds defines the initial value for the BGP
			// KeepaliveTimer (RFC 4271, Section 8).
			// It can not be larger than HoldTimeSeconds. Updating this value
			// will cause a session reset.
			//
			// If not specified, defaults to 30 seconds.
			keepAliveTimeSeconds?: int32 & int & <=65535 & >=1
		}

		// Transport defines the BGP transport parameters for the peer.
		//
		// If not specified, the default transport parameters are used.
		transport?: {
			// PeerPort is the peer port to be used for the BGP session.
			//
			// If not specified, defaults to TCP port 179.
			peerPort?: int32 & int & <=65535 & >=1
		}
	}

	// Status is the running status of the CiliumBGPPeerConfig
	status?: {
		// The current conditions of the CiliumBGPPeerConfig
		conditions?: [...{
			// lastTransitionTime is the last time the condition transitioned
			// from one status to another.
			// This should be when the underlying condition changed. If that
			// is not known, then using the time when the API field changed
			// is acceptable.
			lastTransitionTime!: time.Time

			// message is a human readable message indicating details about
			// the transition.
			// This may be an empty string.
			message!: strings.MaxRunes(
					32768)

			// observedGeneration represents the .metadata.generation that the
			// condition was set based upon.
			// For instance, if .metadata.generation is currently 12, but the
			// .status.conditions[x].observedGeneration is 9, the condition
			// is out of date
			// with respect to the current state of the instance.
			observedGeneration?: int64 & int & >=0

			// reason contains a programmatic identifier indicating the reason
			// for the condition's last transition.
			// Producers of specific condition types may define expected
			// values and meanings for this field,
			// and whether the values are considered a guaranteed API.
			// The value should be a CamelCase string.
			// This field may not be empty.
			reason!: strings.MaxRunes(
					1024) & strings.MinRunes(
					1) & =~"^[A-Za-z]([A-Za-z0-9_,:]*[A-Za-z0-9_])?$"

			// status of the condition, one of True, False, Unknown.
			status!: "True" | "False" | "Unknown"

			// type of condition in CamelCase or in foo.example.com/CamelCase.
			type!: strings.MaxRunes(
				316) & =~"^([a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*/)?(([A-Za-z0-9][-A-Za-z0-9_.]*)?[A-Za-z0-9])$"
		}]
	}

	_embeddedResource: {
		apiVersion!: string
		kind!:       string
		metadata?: {
			...
		}
	}
	apiVersion: "cilium.io/v2"
	kind:       "CiliumBGPPeerConfig"
	metadata!: {
		name!:      string
		namespace?: string
		labels?: [string]: string
		annotations?: [string]: string
		...
	}
}
