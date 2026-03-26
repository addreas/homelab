package v1beta2

#BackingImage: {
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

	// BackingImageSpec defines the desired state of the Longhorn
	// backing image
	spec?: {
		checksum?:   string
		dataEngine?: "v1" | "v2"
		diskFileSpecMap?: [string]: {
			dataEngine?:        "v1" | "v2"
			evictionRequested?: bool
		}
		diskSelector?: [...string]

		// Deprecated. We are now using DiskFileSpecMap to assign
		// different spec to the file on different disks.
		disks?: [string]: string
		minNumberOfCopies?: int
		nodeSelector?: [...string]
		secret?:          string
		secretNamespace?: string
		sourceParameters?: [string]: string
		sourceType?: "download" | "upload" | "export-from-volume" | "restore" | "clone"
	}

	// BackingImageStatus defines the observed state of the Longhorn
	// backing image status
	status?: {
		checksum?: string
		diskFileStatusMap?:
			null | {
				[string]: {
					dataEngine?:              "v1" | "v2"
					lastStateTransitionTime?: string
					message?:                 string
					progress?:                int
					state?:                   string
				}
			}
		diskLastRefAtMap?:
			null | {
				[string]: string
			}
		ownerID?: string

		// Real size of image in bytes, which may be smaller than the size
		// when the file is a sparse file. Will be zero until known (e.g.
		// while a backing image is uploading)
		realSize?:        int64 & int
		size?:            int64 & int
		uuid?:            string
		v2FirstCopyDisk?: string

		// It is pending -> in-progress -> ready/failed
		v2FirstCopyStatus?: string

		// Virtual size of image in bytes, which may be larger than
		// physical size. Will be zero until known (e.g. while a backing
		// image is uploading)
		virtualSize?: int64 & int
	}

	_embeddedResource: {
		apiVersion!: string
		kind!:       string
		metadata?: {
			...
		}
	}
	apiVersion: "longhorn.io/v1beta2"
	kind:       "BackingImage"
	metadata!: {
		name!:      string
		namespace!: string
		labels?: [string]: string
		annotations?: [string]: string
		...
	}
}
