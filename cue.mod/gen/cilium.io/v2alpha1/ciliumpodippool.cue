package v2alpha1

import "strings"

#CiliumPodIPPool: {
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
	metadata?: {}
	spec!: {
		// IPv4 specifies the IPv4 CIDRs and mask sizes of the pool
		ipv4?: {
			// CIDRs is a list of IPv4 CIDRs that are part of the pool.
			cidrs!: [...string] & [_, ...]

			// MaskSize is the mask size of the pool.
			maskSize!: int & <=32 & >=1
		}

		// IPv6 specifies the IPv6 CIDRs and mask sizes of the pool
		ipv6?: {
			// CIDRs is a list of IPv6 CIDRs that are part of the pool.
			cidrs!: [...string] & [_, ...]

			// MaskSize is the mask size of the pool.
			maskSize!: int & <=128 & >=1
		}

		// NamespaceSelector selects the set of Namespaces that are
		// eligible to use
		// this pool. If both PodSelector and NamespaceSelector are
		// specified, a Pod
		// must match both selectors to be eligible for IP allocation from
		// this pool.
		//
		// If NamespaceSelector is empty, the pool can be used by Pods in
		// any namespace
		// (subject to PodSelector constraints).
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

		// PodSelector selects the set of Pods that are eligible to
		// receive IPs from
		// this pool when neither the Pod nor its Namespace specify an
		// explicit
		// `ipam.cilium.io/*` annotation.
		//
		// The selector can match on regular Pod labels and on the
		// following synthetic
		// labels that Cilium adds for convenience:
		//
		// io.kubernetes.pod.namespace – the Pod's namespace
		// io.kubernetes.pod.name – the Pod's name
		//
		// A single Pod must not match more than one pool for the same IP
		// family.
		// If multiple pools match, IP allocation fails for that Pod and a
		// warning event
		// is emitted in the namespace of the Pod.
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

	_embeddedResource: {
		apiVersion!: string
		kind!:       string
		metadata?: {
			...
		}
	}
	apiVersion: "cilium.io/v2alpha1"
	kind:       "CiliumPodIPPool"
	metadata!: {
		name!:      string
		namespace?: string
		labels?: [string]: string
		annotations?: [string]: string
		...
	}
}
