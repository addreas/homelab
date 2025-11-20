package v2alpha1

import "strings"

#CiliumBGPPeeringPolicy: {
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

	// Spec is a human readable description of a BGP peering policy
	spec?: {
		// NodeSelector selects a group of nodes where this BGP Peering
		// Policy applies.
		//
		// If empty / nil this policy applies to all nodes.
		nodeSelector?: {
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

		// A list of CiliumBGPVirtualRouter(s) which instructs
		// the BGP control plane how to instantiate virtual BGP routers.
		virtualRouters!: [...{
			// ExportPodCIDR determines whether to export the Node's private
			// CIDR block
			// to the configured neighbors.
			exportPodCIDR?: bool

			// LocalASN is the ASN of this virtual router.
			// Supports extended 32bit ASNs
			localASN!: int64 & int & <=4294967295 & >=0

			// Neighbors is a list of neighboring BGP peers for this virtual
			// router
			neighbors!: [...{
				// AdvertisedPathAttributes can be used to apply additional path
				// attributes
				// to selected routes when advertising them to the peer.
				// If empty / nil, no additional path attributes are advertised.
				advertisedPathAttributes?: [...{
					// Communities defines a set of community values advertised in the
					// supported BGP Communities path attributes.
					// If nil / not set, no BGP Communities path attribute will be
					// advertised.
					communities?: {
						// Large holds a list of the BGP Large Communities Attribute (RFC
						// 8092) values.
						large?: [...=~"^([0-9]|[1-9][0-9]{1,8}|[1-3][0-9]{9}|4[01][0-9]{8}|42[0-8][0-9]{7}|429[0-3][0-9]{6}|4294[0-8][0-9]{5}|42949[0-5][0-9]{4}|429496[0-6][0-9]{3}|4294967[01][0-9]{2}|42949672[0-8][0-9]|429496729[0-5]):([0-9]|[1-9][0-9]{1,8}|[1-3][0-9]{9}|4[01][0-9]{8}|42[0-8][0-9]{7}|429[0-3][0-9]{6}|4294[0-8][0-9]{5}|42949[0-5][0-9]{4}|429496[0-6][0-9]{3}|4294967[01][0-9]{2}|42949672[0-8][0-9]|429496729[0-5]):([0-9]|[1-9][0-9]{1,8}|[1-3][0-9]{9}|4[01][0-9]{8}|42[0-8][0-9]{7}|429[0-3][0-9]{6}|4294[0-8][0-9]{5}|42949[0-5][0-9]{4}|429496[0-6][0-9]{3}|4294967[01][0-9]{2}|42949672[0-8][0-9]|429496729[0-5])$"]

						// Standard holds a list of "standard" 32-bit BGP Communities
						// Attribute (RFC 1997) values defined as numeric values.
						standard?: [...=~"^([0-9]|[1-9][0-9]{1,8}|[1-3][0-9]{9}|4[01][0-9]{8}|42[0-8][0-9]{7}|429[0-3][0-9]{6}|4294[0-8][0-9]{5}|42949[0-5][0-9]{4}|429496[0-6][0-9]{3}|4294967[01][0-9]{2}|42949672[0-8][0-9]|429496729[0-5])$|^([0-9]|[1-9][0-9]{1,3}|[1-5][0-9]{4}|6[0-4][0-9]{3}|65[0-4][0-9]{2}|655[0-2][0-9]|6553[0-5]):([0-9]|[1-9][0-9]{1,3}|[1-5][0-9]{4}|6[0-4][0-9]{3}|65[0-4][0-9]{2}|655[0-2][0-9]|6553[0-5])$"]

						// WellKnown holds a list "standard" 32-bit BGP Communities
						// Attribute (RFC 1997) values defined as
						// well-known string aliases to their numeric values.
						wellKnown?: [..."internet" | "planned-shut" | "accept-own" | "route-filter-translated-v4" | "route-filter-v4" | "route-filter-translated-v6" | "route-filter-v6" | "llgr-stale" | "no-llgr" | "blackhole" | "no-export" | "no-advertise" | "no-export-subconfed" | "no-peer"]
					}

					// LocalPreference defines the preference value advertised in the
					// BGP Local Preference path attribute.
					// As Local Preference is only valid for iBGP peers, this value
					// will be ignored for eBGP peers
					// (no Local Preference path attribute will be advertised).
					// If nil / not set, the default Local Preference of 100 will be
					// advertised in
					// the Local Preference path attribute for iBGP peers.
					localPreference?: int64 & int & <=4294967295 & >=0

					// Selector selects a group of objects of the SelectorType
					// resulting into routes that will be announced with the
					// configured Attributes.
					// If nil / not set, all objects of the SelectorType are selected.
					selector?: {
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

					// SelectorType defines the object type on which the Selector
					// applies:
					// - For "PodCIDR" the Selector matches k8s CiliumNode resources
					// (path attributes apply to routes announced for PodCIDRs of
					// selected CiliumNodes.
					// Only affects routes of cluster scope / Kubernetes IPAM CIDRs,
					// not Multi-Pool IPAM CIDRs.
					// - For "CiliumLoadBalancerIPPool" the Selector matches
					// CiliumLoadBalancerIPPool custom resources
					// (path attributes apply to routes announced for selected
					// CiliumLoadBalancerIPPools).
					// - For "CiliumPodIPPool" the Selector matches CiliumPodIPPool
					// custom resources
					// (path attributes apply to routes announced for allocated CIDRs
					// of selected CiliumPodIPPools).
					selectorType!: "PodCIDR" | "CiliumLoadBalancerIPPool" | "CiliumPodIPPool"
				}]

				// AuthSecretRef is the name of the secret to use to fetch a TCP
				// authentication password for this peer.
				authSecretRef?: string

				// ConnectRetryTimeSeconds defines the initial value for the BGP
				// ConnectRetryTimer (RFC 4271, Section 8).
				connectRetryTimeSeconds?: int32 & int & <=2147483647 & >=1

				// EBGPMultihopTTL controls the multi-hop feature for eBGP peers.
				// Its value defines the Time To Live (TTL) value used in BGP
				// packets sent to the neighbor.
				// The value 1 implies that eBGP multi-hop feature is disabled
				// (only a single hop is allowed).
				// This field is ignored for iBGP peers.
				eBGPMultihopTTL?: int32 & int & <=255 & >=1

				// Families, if provided, defines a set of AFI/SAFIs the speaker
				// will
				// negotiate with it's peer.
				//
				// If this slice is not provided the default families of IPv6 and
				// IPv4 will
				// be provided.
				families?: [...{
					// Afi is the Address Family Identifier (AFI) of the family.
					afi!: "ipv4" | "ipv6" | "l2vpn" | "ls" | "opaque"

					// Safi is the Subsequent Address Family Identifier (SAFI) of the
					// family.
					safi!: "unicast" | "multicast" | "mpls_label" | "encapsulation" | "vpls" | "evpn" | "ls" | "sr_policy" | "mup" | "mpls_vpn" | "mpls_vpn_multicast" | "route_target_constraints" | "flowspec_unicast" | "flowspec_vpn" | "key_value"
				}]

				// GracefulRestart defines graceful restart parameters which are
				// negotiated
				// with this neighbor. If empty / nil, the graceful restart
				// capability is disabled.
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

				// HoldTimeSeconds defines the initial value for the BGP HoldTimer
				// (RFC 4271, Section 4.2).
				// Updating this value will cause a session reset.
				holdTimeSeconds?: int32 & int & <=65535 & >=3

				// KeepaliveTimeSeconds defines the initial value for the BGP
				// KeepaliveTimer (RFC 4271, Section 8).
				// It can not be larger than HoldTimeSeconds. Updating this value
				// will cause a session reset.
				keepAliveTimeSeconds?: int32 & int & <=65535 & >=1

				// PeerASN is the ASN of the peer BGP router.
				// Supports extended 32bit ASNs
				peerASN!: int64 & int & <=4294967295 & >=0

				// PeerAddress is the IP address of the peer.
				// This must be in CIDR notation and use a /32 to express
				// a single host.
				peerAddress!: string

				// PeerPort is the TCP port of the peer. 1-65535 is the range of
				// valid port numbers that can be specified. If unset, defaults to
				// 179.
				peerPort?: int32 & int & <=65535 & >=1
			}] & [_, ...]

			// PodIPPoolSelector selects CiliumPodIPPools based on labels. The
			// virtual
			// router will announce allocated CIDRs of matching
			// CiliumPodIPPools.
			//
			// If empty / nil no CiliumPodIPPools will be announced.
			podIPPoolSelector?: {
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

			// ServiceAdvertisements selects a group of BGP Advertisement(s)
			// to advertise
			// for the selected services.
			serviceAdvertisements?: [..."LoadBalancerIP" | "ClusterIP" | "ExternalIP"]

			// ServiceSelector selects a group of load balancer services which
			// this
			// virtual router will announce. The loadBalancerClass for a
			// service must
			// be nil or specify a class supported by Cilium, e.g.
			// "io.cilium/bgp-control-plane".
			// Refer to the following document for additional details
			// regarding load balancer
			// classes:
			//
			// https://kubernetes.io/docs/concepts/services-networking/service/#load-balancer-class
			//
			// If empty / nil no services will be announced.
			serviceSelector?: {
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
		}] & [_, ...]
	}

	_embeddedResource: {
		apiVersion!: string
		kind!:       string
		metadata?: {
			...
		}
	}
	apiVersion: "cilium.io/v2alpha1"
	kind:       "CiliumBGPPeeringPolicy"
	metadata!: {
		name!:      string
		namespace?: string
		labels?: [string]: string
		annotations?: [string]: string
		...
	}
}
