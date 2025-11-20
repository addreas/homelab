package v1

#NetworkAttachmentDefinition: {
	_embeddedResource

	// APIVersion defines the versioned schema of this represen tation
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
	metadata?: {}

	// NetworkAttachmentDefinition spec defines the desired state of a
	// network attachment
	spec?: {
		// NetworkAttachmentDefinition config is a JSON-formatted CNI
		// configuration
		config?: string
	}

	_embeddedResource: {
		apiVersion!: string
		kind!:       string
		metadata?: {
			...
		}
	}
	apiVersion: "k8s.cni.cncf.io/v1"
	kind:       "NetworkAttachmentDefinition"
	metadata!: {
		name!:      string
		namespace!: string
		labels?: [string]: string
		annotations?: [string]: string
		...
	}
}
