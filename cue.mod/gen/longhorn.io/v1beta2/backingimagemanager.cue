package v1beta2

#BackingImageManager: {
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

	// BackingImageManagerSpec defines the desired state of the
	// Longhorn backing image manager
	spec?: {
		backingImages?: [string]: string
		diskPath?: string
		diskUUID?: string
		image?:    string
		nodeID?:   string
	}

	// BackingImageManagerStatus defines the observed state of the
	// Longhorn backing image manager
	status?: {
		apiMinVersion?: int
		apiVersion?:    int
		backingImageFileMap?:
			null | {
				[string]: {
					currentChecksum?:      string
					message?:              string
					name?:                 string
					progress?:             int
					realSize?:             int64 & int
					senderManagerAddress?: string
					sendingReference?:     int
					size?:                 int64 & int
					state?:                string
					uuid?:                 string
					virtualSize?:          int64 & int
				}
			}
		currentState?: string
		ip?:           string
		ownerID?:      string
		storageIP?:    string
	}

	_embeddedResource: {
		apiVersion!: string
		kind!:       string
		metadata?: {
			...
		}
	}
	apiVersion: "longhorn.io/v1beta2"
	kind:       "BackingImageManager"
	metadata!: {
		name!:      string
		namespace!: string
		labels?: [string]: string
		annotations?: [string]: string
		...
	}
}
