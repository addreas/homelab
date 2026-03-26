package v1beta2

#SupportBundle: {
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

	// SupportBundleSpec defines the desired state of the Longhorn
	// SupportBundle
	spec?: {
		// A brief description of the issue
		description!: string

		// The issue URL
		issueURL?:
			null | string

		// The preferred responsible controller node ID.
		nodeID?: string
	}

	// SupportBundleStatus defines the observed state of the Longhorn
	// SupportBundle
	status?: {
		conditions?: [...{
			// Last time we probed the condition.
			lastProbeTime?: string

			// Last time the condition transitioned from one status to
			// another.
			lastTransitionTime?: string

			// Human-readable message indicating details about last
			// transition.
			message?: string

			// Unique, one-word, CamelCase reason for the condition's last
			// transition.
			reason?: string

			// Status is the status of the condition.
			// Can be True, False, Unknown.
			status?: string

			// Type is the type of the condition.
			type?: string
		}]
		filename?: string
		filesize?: int64 & int

		// The support bundle manager image
		image?: string

		// The support bundle manager IP
		managerIP?: string

		// The current responsible controller node ID
		ownerID?:  string
		progress?: int
		state?:    string
	}

	_embeddedResource: {
		apiVersion!: string
		kind!:       string
		metadata?: {
			...
		}
	}
	apiVersion: "longhorn.io/v1beta2"
	kind:       "SupportBundle"
	metadata!: {
		name!:      string
		namespace!: string
		labels?: [string]: string
		annotations?: [string]: string
		...
	}
}
