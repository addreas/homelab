package v2alpha1

import "strings"

#CiliumBGPAdvertisement: {
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
	spec!: {
		// Advertisements is a list of BGP advertisements.
		advertisements!: [...{
			// AdvertisementType defines type of advertisement which has to be
			// advertised.
			advertisementType!: "PodCIDR" | "CiliumPodIPPool" | "Service"

			// Attributes defines additional attributes to set to the
			// advertised routes.
			// If not specified, no additional attributes are set.
			attributes?: {
				// Communities sets the community attributes in the route.
				// If not specified, no community attribute is set.
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

				// LocalPreference sets the local preference attribute in the
				// route.
				// If not specified, no local preference attribute is set.
				localPreference?: int64 & int
			}

			// Selector is a label selector to select objects of the type
			// specified by AdvertisementType.
			// For the PodCIDR AdvertisementType it is not applicable. For
			// other advertisement types,
			// if not specified, no objects of the type specified by
			// AdvertisementType are selected for advertisement.
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

			// Service defines configuration options for advertisementType
			// service.
			service?: {
				// Addresses is a list of service address types which needs to be
				// advertised via BGP.
				addresses!: [..."LoadBalancerIP" | "ClusterIP" | "ExternalIP"] & [_, ...]

				// IPv4 mask to aggregate BGP route advertisements of service
				aggregationLengthIPv4?: int & <=31 & >=0

				// IPv6 mask to aggregate BGP route advertisements of service
				aggregationLengthIPv6?: int & <=127 & >=0
			}
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
	kind:       "CiliumBGPAdvertisement"
	metadata!: {
		name!:      string
		namespace?: string
		labels?: [string]: string
		annotations?: [string]: string
		...
	}
}
