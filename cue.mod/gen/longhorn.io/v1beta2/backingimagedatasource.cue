package v1beta2

#BackingImageDataSource: {
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

	// BackingImageDataSourceSpec defines the desired state of the
	// Longhorn backing image data source
	spec?: {
		checksum?:        string
		diskPath?:        string
		diskUUID?:        string
		fileTransferred?: bool
		nodeID?:          string
		parameters?: [string]: string
		sourceType?: "download" | "upload" | "export-from-volume" | "restore" | "clone"
		uuid?:       string
	}

	// BackingImageDataSourceStatus defines the observed state of the
	// Longhorn backing image data source
	status?: {
		checksum?:     string
		currentState?: string
		ip?:           string
		message?:      string
		ownerID?:      string
		progress?:     int
		runningParameters?:
			null | {
				[string]: string
			}
		size?:      int64 & int
		storageIP?: string
	}

	_embeddedResource: {
		apiVersion!: string
		kind!:       string
		metadata?: {
			...
		}
	}
	apiVersion: "longhorn.io/v1beta2"
	kind:       "BackingImageDataSource"
	metadata!: {
		name!:      string
		namespace!: string
		labels?: [string]: string
		annotations?: [string]: string
		...
	}
}
