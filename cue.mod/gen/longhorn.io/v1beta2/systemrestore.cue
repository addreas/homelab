package v1beta2

#SystemRestore: {
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

	// SystemRestoreSpec defines the desired state of the Longhorn
	// SystemRestore
	spec?: {
		// The system backup name in the object store.
		systemBackup!: string
	}

	// SystemRestoreStatus defines the observed state of the Longhorn
	// SystemRestore
	status?: {
		conditions?:
			null | [...{
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

		// The node ID of the responsible controller to reconcile this
		// SystemRestore.
		ownerID?: string

		// The source system backup URL.
		sourceURL?: string

		// The system restore state.
		state?: string
	}

	_embeddedResource: {
		apiVersion!: string
		kind!:       string
		metadata?: {
			...
		}
	}
	apiVersion: "longhorn.io/v1beta2"
	kind:       "SystemRestore"
	metadata!: {
		name!:      string
		namespace!: string
		labels?: [string]: string
		annotations?: [string]: string
		...
	}
}
