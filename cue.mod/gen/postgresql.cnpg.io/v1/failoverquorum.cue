package v1

#FailoverQuorum: {
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
	metadata!: {}

	// Most recently observed status of the failover quorum.
	status?: {
		// Contains the latest reported Method value.
		method?: string

		// Primary is the name of the primary instance that updated
		// this object the latest time.
		primary?: string

		// StandbyNames is the list of potentially synchronous
		// instance names.
		standbyNames?: [...string]

		// StandbyNumber is the number of synchronous standbys that
		// transactions
		// need to wait for replies from.
		standbyNumber?: int
	}

	_embeddedResource: {
		apiVersion!: string
		kind!:       string
		metadata?: {
			...
		}
	}
	apiVersion: "postgresql.cnpg.io/v1"
	kind:       "FailoverQuorum"
	metadata!: {
		name!:      string
		namespace!: string
		labels?: [string]: string
		annotations?: [string]: string
		...
	}
}
