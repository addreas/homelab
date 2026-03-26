package v1beta2

#Replica: {
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

	// ReplicaSpec defines the desired state of the Longhorn replica
	spec?: {
		active?:            bool
		backingImage?:      string
		dataDirectoryName?: string
		dataEngine?:        "v1" | "v2"
		desireState?:       string
		diskID?:            string
		diskPath?:          string
		engineName?:        string
		evictionRequested?: bool

		// FailedAt is set when a running replica fails or when a running
		// engine is unable to use a replica for any reason.
		// FailedAt indicates the time the failure occurred. When FailedAt
		// is set, a replica is likely to have useful
		// (though possibly stale) data. A replica with FailedAt set must
		// be rebuilt from a non-failed replica (or it can
		// be used in a salvage if all replicas are failed). FailedAt is
		// cleared before a rebuild or salvage. FailedAt may
		// be later than the corresponding entry in an engine's
		// replicaTransitionTimeMap because it is set when the volume
		// controller acknowledges the change.
		failedAt?:         string
		hardNodeAffinity?: string

		// HealthyAt is set the first time a replica becomes read/write in
		// an engine after creation or rebuild. HealthyAt
		// indicates the time the last successful rebuild occurred. When
		// HealthyAt is set, a replica is likely to have
		// useful (though possibly stale) data. HealthyAt is cleared
		// before a rebuild. HealthyAt may be later than the
		// corresponding entry in an engine's replicaTransitionTimeMap
		// because it is set when the volume controller
		// acknowledges the change.
		healthyAt?: string
		image?:     string

		// LastFailedAt is always set at the same time as FailedAt. Unlike
		// FailedAt, LastFailedAt is never cleared.
		// LastFailedAt is not a reliable indicator of the state of a
		// replica's data. For example, a replica with
		// LastFailedAt may already be healthy and in use again. However,
		// because it is never cleared, it can be compared to
		// LastHealthyAt to help prevent dangerous replica deletion in
		// some corner cases. LastFailedAt may be later than the
		// corresponding entry in an engine's replicaTransitionTimeMap
		// because it is set when the volume controller
		// acknowledges the change.
		lastFailedAt?: string

		// LastHealthyAt is set every time a replica becomes read/write in
		// an engine. Unlike HealthyAt, LastHealthyAt is
		// never cleared. LastHealthyAt is not a reliable indicator of the
		// state of a replica's data. For example, a
		// replica with LastHealthyAt set may be in the middle of a
		// rebuild. However, because it is never cleared, it can be
		// compared to LastFailedAt to help prevent dangerous replica
		// deletion in some corner cases. LastHealthyAt may be
		// later than the corresponding entry in an engine's
		// replicaTransitionTimeMap because it is set when the volume
		// controller acknowledges the change.
		lastHealthyAt?: string
		logRequested?:  bool

		// MigrationEngineName is indicating the migrating engine which
		// current connected to this replica. This is only
		// used for live migration of v2 data engine
		migrationEngineName?:              string
		nodeID?:                           string
		rebuildRetryCount?:                int
		revisionCounterDisabled?:          bool
		salvageRequested?:                 bool
		snapshotMaxCount?:                 int
		snapshotMaxSize?:                  string
		unmapMarkDiskChainRemovedEnabled?: bool
		volumeName?:                       string
		volumeSize?:                       string
	}

	// ReplicaStatus defines the observed state of the Longhorn
	// replica
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
		currentImage?:        string
		currentState?:        string
		instanceManagerName?: string
		ip?:                  string
		logFetched?:          bool
		ownerID?:             string
		port?:                int
		salvageExecuted?:     bool
		started?:             bool
		starting?:            bool
		storageIP?:           string
		ublkID?:              int32 & int
		uuid?:                string
	}

	_embeddedResource: {
		apiVersion!: string
		kind!:       string
		metadata?: {
			...
		}
	}
	apiVersion: "longhorn.io/v1beta2"
	kind:       "Replica"
	metadata!: {
		name!:      string
		namespace!: string
		labels?: [string]: string
		annotations?: [string]: string
		...
	}
}
