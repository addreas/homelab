package v2

import (
	"list"
	"strings"
	"time"
)

#CiliumBGPClusterConfig: {
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

	// Spec defines the desired cluster configuration of the BGP
	// control plane.
	spec!: {
		// A list of CiliumBGPInstance(s) which instructs
		// the BGP control plane how to instantiate virtual BGP routers.
		bgpInstances!: list.MaxItems(16) & [...{
			// LocalASN is the ASN of this BGP instance.
			// Supports extended 32bit ASNs.
			localASN?: int64 & int & <=4294967295 & >=1

			// LocalPort is the port on which the BGP daemon listens for
			// incoming connections.
			//
			// If not specified, BGP instance will not listen for incoming
			// connections.
			localPort?: int32 & int & <=65535 & >=1

			// Name is the name of the BGP instance. It is a unique identifier
			// for the BGP instance
			// within the cluster configuration.
			name!: strings.MaxRunes(
				255) & strings.MinRunes(
				1)

			// Peers is a list of neighboring BGP peers for this virtual
			// router
			peers?: [...{
				// AutoDiscovery is the configuration for auto-discovery of the
				// peer address.
				autoDiscovery?: {
					// defaultGateway is the configuration for auto-discovery of the
					// default gateway.
					defaultGateway?: {
						// addressFamily is the address family of the default gateway.
						addressFamily!: "ipv4" | "ipv6"
					}

					// mode is the mode of the auto-discovery.
					mode!: matchN(2, ["DefaultGateway", "DefaultGateway"])
				}

				// Name is the name of the BGP peer. It is a unique identifier for
				// the peer within the BGP instance.
				name!: strings.MaxRunes(
					255) & strings.MinRunes(
					1)

				// PeerASN is the ASN of the peer BGP router.
				// Supports extended 32bit ASNs.
				//
				// If peerASN is 0, the BGP OPEN message validation of ASN will be
				// disabled and
				// ASN will be determined based on peer's OPEN message.
				peerASN?: int64 & int & <=4294967295 & >=0

				// PeerAddress is the IP address of the neighbor.
				// Supports IPv4 and IPv6 addresses.
				peerAddress?: =~"((^\\s*((([0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5])\\.){3}([0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5]))\\s*$)|(^\\s*((([0-9A-Fa-f]{1,4}:){7}([0-9A-Fa-f]{1,4}|:))|(([0-9A-Fa-f]{1,4}:){6}(:[0-9A-Fa-f]{1,4}|((25[0-5]|2[0-4]\\d|1\\d\\d|[1-9]?\\d)(\\.(25[0-5]|2[0-4]\\d|1\\d\\d|[1-9]?\\d)){3})|:))|(([0-9A-Fa-f]{1,4}:){5}(((:[0-9A-Fa-f]{1,4}){1,2})|:((25[0-5]|2[0-4]\\d|1\\d\\d|[1-9]?\\d)(\\.(25[0-5]|2[0-4]\\d|1\\d\\d|[1-9]?\\d)){3})|:))|(([0-9A-Fa-f]{1,4}:){4}(((:[0-9A-Fa-f]{1,4}){1,3})|((:[0-9A-Fa-f]{1,4})?:((25[0-5]|2[0-4]\\d|1\\d\\d|[1-9]?\\d)(\\.(25[0-5]|2[0-4]\\d|1\\d\\d|[1-9]?\\d)){3}))|:))|(([0-9A-Fa-f]{1,4}:){3}(((:[0-9A-Fa-f]{1,4}){1,4})|((:[0-9A-Fa-f]{1,4}){0,2}:((25[0-5]|2[0-4]\\d|1\\d\\d|[1-9]?\\d)(\\.(25[0-5]|2[0-4]\\d|1\\d\\d|[1-9]?\\d)){3}))|:))|(([0-9A-Fa-f]{1,4}:){2}(((:[0-9A-Fa-f]{1,4}){1,5})|((:[0-9A-Fa-f]{1,4}){0,3}:((25[0-5]|2[0-4]\\d|1\\d\\d|[1-9]?\\d)(\\.(25[0-5]|2[0-4]\\d|1\\d\\d|[1-9]?\\d)){3}))|:))|(([0-9A-Fa-f]{1,4}:){1}(((:[0-9A-Fa-f]{1,4}){1,6})|((:[0-9A-Fa-f]{1,4}){0,4}:((25[0-5]|2[0-4]\\d|1\\d\\d|[1-9]?\\d)(\\.(25[0-5]|2[0-4]\\d|1\\d\\d|[1-9]?\\d)){3}))|:))|(:(((:[0-9A-Fa-f]{1,4}){1,7})|((:[0-9A-Fa-f]{1,4}){0,5}:((25[0-5]|2[0-4]\\d|1\\d\\d|[1-9]?\\d)(\\.(25[0-5]|2[0-4]\\d|1\\d\\d|[1-9]?\\d)){3}))|:)))(%.+)?\\s*$))"

				// PeerConfigRef is a reference to a peer configuration resource.
				// If not specified, the default BGP configuration is used for
				// this peer.
				peerConfigRef?: {
					// Name is the name of the peer config resource.
					// Name refers to the name of a Kubernetes object (typically a
					// CiliumBGPPeerConfig).
					name!: string
				}
			}]
		}] & [_, ...]

		// NodeSelector selects a group of nodes where this BGP Cluster
		// config applies.
		// If empty / nil this config applies to all nodes.
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
	}

	// Status is a running status of the cluster configuration
	status?: {
		// The current conditions of the CiliumBGPClusterConfig
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
	kind:       "CiliumBGPClusterConfig"
	metadata!: {
		name!:      string
		namespace?: string
		labels?: [string]: string
		annotations?: [string]: string
		...
	}
}
