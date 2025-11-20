package v2alpha1

#CiliumNodeConfig: {
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

	// Spec is the desired Cilium configuration overrides for a given
	// node
	spec!: {
		// Defaults is treated the same as the cilium-config ConfigMap - a
		// set
		// of key-value pairs parsed by the agent and operator processes.
		// Each key must be a valid config-map data field (i.e. a-z, A-Z,
		// -, _, and .)
		defaults!: [string]: string

		// NodeSelector is a label selector that determines to which nodes
		// this configuration applies.
		// If not supplied, then this config applies to no nodes. If
		// empty, then it applies to all nodes.
		nodeSelector!: {
			// matchExpressions is a list of label selector requirements. The
			// requirements are ANDed.
			matchExpressions?: [...{
				// key is the label key that the selector applies to.
				key!: string

				// operator represents a key's relationship to a set of values.
				// Valid operators are In, NotIn, Exists and DoesNotExist.
				operator!: string

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
			matchLabels?: [string]: string
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
	kind:       "CiliumNodeConfig"
	metadata!: {
		name!:      string
		namespace!: string
		labels?: [string]: string
		annotations?: [string]: string
		...
	}
}
