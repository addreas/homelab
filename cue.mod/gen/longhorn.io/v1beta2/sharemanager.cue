package v1beta2

#ShareManager: {
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

	// ShareManagerSpec defines the desired state of the Longhorn
	// share manager
	spec?: {
		// Share manager image used for creating a share manager pod
		image?: string
	}

	// ShareManagerStatus defines the observed state of the Longhorn
	// share manager
	status?: {
		// NFS endpoint that can access the mounted filesystem of the
		// volume
		endpoint?: string

		// The node ID on which the controller is responsible to reconcile
		// this share manager resource
		ownerID?: string

		// The state of the share manager resource
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
	kind:       "ShareManager"
	metadata!: {
		name!:      string
		namespace!: string
		labels?: [string]: string
		annotations?: [string]: string
		...
	}
}
