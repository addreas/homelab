package v1beta2

#Snapshot: {
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

	// SnapshotSpec defines the desired state of Longhorn Snapshot
	spec?: {
		// require creating a new snapshot
		createSnapshot?: bool

		// The labels of snapshot
		labels?:
			null | {
				[string]: string
			}

		// the volume that this snapshot belongs to.
		// This field is immutable after creation.
		volume!: string
	}

	// SnapshotStatus defines the observed state of Longhorn Snapshot
	status?: {
		checksum?: string
		children?:
			null | {
				[string]: bool
			}
		creationTime?: string
		error?:        string
		labels?:
			null | {
				[string]: string
			}
		markRemoved?: bool
		ownerID?:     string
		parent?:      string
		readyToUse?:  bool
		restoreSize?: int64 & int
		size?:        int64 & int
		userCreated?: bool
	}

	_embeddedResource: {
		apiVersion!: string
		kind!:       string
		metadata?: {
			...
		}
	}
	apiVersion: "longhorn.io/v1beta2"
	kind:       "Snapshot"
	metadata!: {
		name!:      string
		namespace!: string
		labels?: [string]: string
		annotations?: [string]: string
		...
	}
}
