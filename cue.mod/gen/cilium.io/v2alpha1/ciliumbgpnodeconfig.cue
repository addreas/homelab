package v2alpha1

import (
	"list"
	"strings"
	"time"
)

#CiliumBGPNodeConfig: {
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
	// CiliumBGPNodeConfig.
	spec!: {
		// BGPInstances is a list of BGP router instances on the node.
		bgpInstances!: list.MaxItems(16) & [...{
			// LocalASN is the ASN of this virtual router.
			// Supports extended 32bit ASNs.
			localASN?: int64 & int & <=4294967295 & >=1

			// LocalPort is the port on which the BGP daemon listens for
			// incoming connections.
			//
			// If not specified, BGP instance will not listen for incoming
			// connections.
			localPort?: int32 & int & <=65535 & >=1

			// Name is the name of the BGP instance. This name is used to
			// identify the BGP instance on the node.
			name!: strings.MaxRunes(
				255) & strings.MinRunes(
				1)

			// Peers is a list of neighboring BGP peers for this virtual
			// router
			peers?: [...{
				// LocalAddress is the IP address of the local interface to use
				// for the peering session.
				// This configuration is derived from CiliumBGPNodeConfigOverride
				// resource. If not specified, the local address will be used for
				// setting up peering.
				localAddress?: =~"((^\\s*((([0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5])\\.){3}([0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5]))\\s*$)|(^\\s*((([0-9A-Fa-f]{1,4}:){7}([0-9A-Fa-f]{1,4}|:))|(([0-9A-Fa-f]{1,4}:){6}(:[0-9A-Fa-f]{1,4}|((25[0-5]|2[0-4]\\d|1\\d\\d|[1-9]?\\d)(\\.(25[0-5]|2[0-4]\\d|1\\d\\d|[1-9]?\\d)){3})|:))|(([0-9A-Fa-f]{1,4}:){5}(((:[0-9A-Fa-f]{1,4}){1,2})|:((25[0-5]|2[0-4]\\d|1\\d\\d|[1-9]?\\d)(\\.(25[0-5]|2[0-4]\\d|1\\d\\d|[1-9]?\\d)){3})|:))|(([0-9A-Fa-f]{1,4}:){4}(((:[0-9A-Fa-f]{1,4}){1,3})|((:[0-9A-Fa-f]{1,4})?:((25[0-5]|2[0-4]\\d|1\\d\\d|[1-9]?\\d)(\\.(25[0-5]|2[0-4]\\d|1\\d\\d|[1-9]?\\d)){3}))|:))|(([0-9A-Fa-f]{1,4}:){3}(((:[0-9A-Fa-f]{1,4}){1,4})|((:[0-9A-Fa-f]{1,4}){0,2}:((25[0-5]|2[0-4]\\d|1\\d\\d|[1-9]?\\d)(\\.(25[0-5]|2[0-4]\\d|1\\d\\d|[1-9]?\\d)){3}))|:))|(([0-9A-Fa-f]{1,4}:){2}(((:[0-9A-Fa-f]{1,4}){1,5})|((:[0-9A-Fa-f]{1,4}){0,3}:((25[0-5]|2[0-4]\\d|1\\d\\d|[1-9]?\\d)(\\.(25[0-5]|2[0-4]\\d|1\\d\\d|[1-9]?\\d)){3}))|:))|(([0-9A-Fa-f]{1,4}:){1}(((:[0-9A-Fa-f]{1,4}){1,6})|((:[0-9A-Fa-f]{1,4}){0,4}:((25[0-5]|2[0-4]\\d|1\\d\\d|[1-9]?\\d)(\\.(25[0-5]|2[0-4]\\d|1\\d\\d|[1-9]?\\d)){3}))|:))|(:(((:[0-9A-Fa-f]{1,4}){1,7})|((:[0-9A-Fa-f]{1,4}){0,5}:((25[0-5]|2[0-4]\\d|1\\d\\d|[1-9]?\\d)(\\.(25[0-5]|2[0-4]\\d|1\\d\\d|[1-9]?\\d)){3}))|:)))(%.+)?\\s*$))"

				// Name is the name of the BGP peer. This name is used to identify
				// the BGP peer for the BGP instance.
				name!: string

				// PeerASN is the ASN of the peer BGP router.
				// Supports extended 32bit ASNs
				peerASN?: int64 & int & <=4294967295 & >=0

				// PeerAddress is the IP address of the neighbor.
				// Supports IPv4 and IPv6 addresses.
				peerAddress?: =~"((^\\s*((([0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5])\\.){3}([0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5]))\\s*$)|(^\\s*((([0-9A-Fa-f]{1,4}:){7}([0-9A-Fa-f]{1,4}|:))|(([0-9A-Fa-f]{1,4}:){6}(:[0-9A-Fa-f]{1,4}|((25[0-5]|2[0-4]\\d|1\\d\\d|[1-9]?\\d)(\\.(25[0-5]|2[0-4]\\d|1\\d\\d|[1-9]?\\d)){3})|:))|(([0-9A-Fa-f]{1,4}:){5}(((:[0-9A-Fa-f]{1,4}){1,2})|:((25[0-5]|2[0-4]\\d|1\\d\\d|[1-9]?\\d)(\\.(25[0-5]|2[0-4]\\d|1\\d\\d|[1-9]?\\d)){3})|:))|(([0-9A-Fa-f]{1,4}:){4}(((:[0-9A-Fa-f]{1,4}){1,3})|((:[0-9A-Fa-f]{1,4})?:((25[0-5]|2[0-4]\\d|1\\d\\d|[1-9]?\\d)(\\.(25[0-5]|2[0-4]\\d|1\\d\\d|[1-9]?\\d)){3}))|:))|(([0-9A-Fa-f]{1,4}:){3}(((:[0-9A-Fa-f]{1,4}){1,4})|((:[0-9A-Fa-f]{1,4}){0,2}:((25[0-5]|2[0-4]\\d|1\\d\\d|[1-9]?\\d)(\\.(25[0-5]|2[0-4]\\d|1\\d\\d|[1-9]?\\d)){3}))|:))|(([0-9A-Fa-f]{1,4}:){2}(((:[0-9A-Fa-f]{1,4}){1,5})|((:[0-9A-Fa-f]{1,4}){0,3}:((25[0-5]|2[0-4]\\d|1\\d\\d|[1-9]?\\d)(\\.(25[0-5]|2[0-4]\\d|1\\d\\d|[1-9]?\\d)){3}))|:))|(([0-9A-Fa-f]{1,4}:){1}(((:[0-9A-Fa-f]{1,4}){1,6})|((:[0-9A-Fa-f]{1,4}){0,4}:((25[0-5]|2[0-4]\\d|1\\d\\d|[1-9]?\\d)(\\.(25[0-5]|2[0-4]\\d|1\\d\\d|[1-9]?\\d)){3}))|:))|(:(((:[0-9A-Fa-f]{1,4}){1,7})|((:[0-9A-Fa-f]{1,4}){0,5}:((25[0-5]|2[0-4]\\d|1\\d\\d|[1-9]?\\d)(\\.(25[0-5]|2[0-4]\\d|1\\d\\d|[1-9]?\\d)){3}))|:)))(%.+)?\\s*$))"

				// PeerConfigRef is a reference to a peer configuration resource.
				// If not specified, the default BGP configuration is used for
				// this peer.
				peerConfigRef?: {
					// Group is the group of the peer config resource.
					// If not specified, the default of "cilium.io" is used.
					group?: string

					// Kind is the kind of the peer config resource.
					// If not specified, the default of "CiliumBGPPeerConfig" is used.
					kind?: string

					// Name is the name of the peer config resource.
					// Name refers to the name of a Kubernetes object (typically a
					// CiliumBGPPeerConfig).
					name!: string
				}
			}]

			// RouterID is the BGP router ID of this virtual router.
			// This configuration is derived from CiliumBGPNodeConfigOverride
			// resource.
			//
			// If not specified, the router ID will be derived from the node
			// local address.
			routerID?: string
		}] & [_, ...]
	}

	// Status is the most recently observed status of the
	// CiliumBGPNodeConfig.
	status?: {
		// BGPInstances is the status of the BGP instances on the node.
		bgpInstances?: [...{
			// LocalASN is the ASN of this BGP instance.
			localASN?: int64 & int

			// Name is the name of the BGP instance. This name is used to
			// identify the BGP instance on the node.
			name!: string

			// PeerStatuses is the state of the BGP peers for this BGP
			// instance.
			peers?: [...{
				// EstablishedTime is the time when the peering session was
				// established.
				// It is represented in RFC3339 form and is in UTC.
				establishedTime?: string

				// Name is the name of the BGP peer.
				name!: string

				// PeerASN is the ASN of the neighbor.
				peerASN?: int64 & int

				// PeerAddress is the IP address of the neighbor.
				peerAddress!: string

				// PeeringState is last known state of the peering session.
				peeringState?: string

				// RouteCount is the number of routes exchanged with this peer per
				// AFI/SAFI.
				routeCount?: [...{
					// Advertised is the number of routes advertised to this peer.
					advertised?: int32 & int

					// Afi is the Address Family Identifier (AFI) of the family.
					afi!: "ipv4" | "ipv6" | "l2vpn" | "ls" | "opaque"

					// Received is the number of routes received from this peer.
					received?: int32 & int

					// Safi is the Subsequent Address Family Identifier (SAFI) of the
					// family.
					safi!: "unicast" | "multicast" | "mpls_label" | "encapsulation" | "vpls" | "evpn" | "ls" | "sr_policy" | "mup" | "mpls_vpn" | "mpls_vpn_multicast" | "route_target_constraints" | "flowspec_unicast" | "flowspec_vpn" | "key_value"
				}]

				// Timers is the state of the negotiated BGP timers for this peer.
				timers?: {
					// AppliedHoldTimeSeconds is the negotiated hold time for this
					// peer.
					appliedHoldTimeSeconds?: int32 & int

					// AppliedKeepaliveSeconds is the negotiated keepalive time for
					// this peer.
					appliedKeepaliveSeconds?: int32 & int
				}
			}]
		}]

		// The current conditions of the CiliumBGPNodeConfig
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
	apiVersion: "cilium.io/v2alpha1"
	kind:       "CiliumBGPNodeConfig"
	metadata!: {
		name!:      string
		namespace?: string
		labels?: [string]: string
		annotations?: [string]: string
		...
	}
}
