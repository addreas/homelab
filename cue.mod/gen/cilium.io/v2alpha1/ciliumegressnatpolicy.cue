package v2alpha1

import "strings"

#CiliumEgressNATPolicy: {
	_embeddedResource

	// APIVersion defines the versioned schema of this representation
	// of an object. Servers should convert recognized schemas to the
	// latest internal value, and may reject unrecognized values.
	// More info:
	// https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#resources
	apiVersion?: string

	// Kind is a string value representing the REST resource this
	// object represents. Servers may infer this from the endpoint
	// the client submits requests to. Cannot be updated. In
	// CamelCase. More info:
	// https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#types-kinds
	kind?: string
	metadata!: {}
	spec?: {
		// DestinationCIDRs is a list of destination CIDRs for destination
		// IP addresses. If a destination IP matches any one CIDR, it
		// will be selected.
		destinationCIDRs!: [...=~"^(?:(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\/([0-9]|[1-2][0-9]|3[0-2])$"]

		// Egress represents a list of rules by which egress traffic is
		// filtered from the source pods.
		egress!: [...{
			// Selects Namespaces using cluster-scoped labels. This field
			// follows standard label selector semantics; if present but
			// empty, it selects all namespaces.
			namespaceSelector?: {
				// matchExpressions is a list of label selector requirements. The
				// requirements are ANDed.
				matchExpressions?: [...{
					// key is the label key that the selector applies to.
					key!: string

					// operator represents a key's relationship to a set of values.
					// Valid operators are In, NotIn, Exists and DoesNotExist.
					operator!: "In" | "NotIn" | "Exists" | "DoesNotExist"

					// values is an array of string values. If the operator is In or
					// NotIn, the values array must be non-empty. If the operator is
					// Exists or DoesNotExist, the values array must be empty. This
					// array is replaced during a strategic merge patch.
					values?: [...string]
				}]

				// matchLabels is a map of {key,value} pairs. A single {key,value}
				// in the matchLabels map is equivalent to an element of
				// matchExpressions, whose key field is "key", the operator is
				// "In", and the values array contains only "value". The
				// requirements are ANDed.
				matchLabels?: [string]: strings.MaxRunes(
							63) & =~"^(([A-Za-z0-9][-A-Za-z0-9_.]*)?[A-Za-z0-9])?$"
			}

			// This is a label selector which selects Pods. This field follows
			// standard label selector semantics; if present but empty, it
			// selects all pods.
			podSelector?: {
				// matchExpressions is a list of label selector requirements. The
				// requirements are ANDed.
				matchExpressions?: [...{
					// key is the label key that the selector applies to.
					key!: string

					// operator represents a key's relationship to a set of values.
					// Valid operators are In, NotIn, Exists and DoesNotExist.
					operator!: "In" | "NotIn" | "Exists" | "DoesNotExist"

					// values is an array of string values. If the operator is In or
					// NotIn, the values array must be non-empty. If the operator is
					// Exists or DoesNotExist, the values array must be empty. This
					// array is replaced during a strategic merge patch.
					values?: [...string]
				}]

				// matchLabels is a map of {key,value} pairs. A single {key,value}
				// in the matchLabels map is equivalent to an element of
				// matchExpressions, whose key field is "key", the operator is
				// "In", and the values array contains only "value". The
				// requirements are ANDed.
				matchLabels?: [string]: strings.MaxRunes(
							63) & =~"^(([A-Za-z0-9][-A-Za-z0-9_.]*)?[A-Za-z0-9])?$"
			}
		}]

		// EgressSourceIP is a source ip address that the egress traffic
		// is redirected to and SNATed with.
		// Example: When it is set to "192.168.1.100", matched egress
		// packets will be redirected to node with ip 192.168.1.100 and
		// SNAT’ed with IP address 192.168.1.100.
		egressSourceIP!: =~"((^\\s*((([0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5])\\.){3}([0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5]))\\s*$)|(^\\s*((([0-9A-Fa-f]{1,4}:){7}([0-9A-Fa-f]{1,4}|:))|(([0-9A-Fa-f]{1,4}:){6}(:[0-9A-Fa-f]{1,4}|((25[0-5]|2[0-4]\\d|1\\d\\d|[1-9]?\\d)(\\.(25[0-5]|2[0-4]\\d|1\\d\\d|[1-9]?\\d)){3})|:))|(([0-9A-Fa-f]{1,4}:){5}(((:[0-9A-Fa-f]{1,4}){1,2})|:((25[0-5]|2[0-4]\\d|1\\d\\d|[1-9]?\\d)(\\.(25[0-5]|2[0-4]\\d|1\\d\\d|[1-9]?\\d)){3})|:))|(([0-9A-Fa-f]{1,4}:){4}(((:[0-9A-Fa-f]{1,4}){1,3})|((:[0-9A-Fa-f]{1,4})?:((25[0-5]|2[0-4]\\d|1\\d\\d|[1-9]?\\d)(\\.(25[0-5]|2[0-4]\\d|1\\d\\d|[1-9]?\\d)){3}))|:))|(([0-9A-Fa-f]{1,4}:){3}(((:[0-9A-Fa-f]{1,4}){1,4})|((:[0-9A-Fa-f]{1,4}){0,2}:((25[0-5]|2[0-4]\\d|1\\d\\d|[1-9]?\\d)(\\.(25[0-5]|2[0-4]\\d|1\\d\\d|[1-9]?\\d)){3}))|:))|(([0-9A-Fa-f]{1,4}:){2}(((:[0-9A-Fa-f]{1,4}){1,5})|((:[0-9A-Fa-f]{1,4}){0,3}:((25[0-5]|2[0-4]\\d|1\\d\\d|[1-9]?\\d)(\\.(25[0-5]|2[0-4]\\d|1\\d\\d|[1-9]?\\d)){3}))|:))|(([0-9A-Fa-f]{1,4}:){1}(((:[0-9A-Fa-f]{1,4}){1,6})|((:[0-9A-Fa-f]{1,4}){0,4}:((25[0-5]|2[0-4]\\d|1\\d\\d|[1-9]?\\d)(\\.(25[0-5]|2[0-4]\\d|1\\d\\d|[1-9]?\\d)){3}))|:))|(:(((:[0-9A-Fa-f]{1,4}){1,7})|((:[0-9A-Fa-f]{1,4}){0,5}:((25[0-5]|2[0-4]\\d|1\\d\\d|[1-9]?\\d)(\\.(25[0-5]|2[0-4]\\d|1\\d\\d|[1-9]?\\d)){3}))|:)))(%.+)?\\s*$))"
	}

	_embeddedResource: {
		apiVersion!: string
		kind!:       string
		metadata?: {
			...
		}
	}
	apiVersion: "cilium.io/v2alpha1"
	kind:       "CiliumEgressNATPolicy"
	metadata!: {
		name!:      string
		namespace?: string
		labels?: [string]: string
		annotations?: [string]: string
		...
	}
}
