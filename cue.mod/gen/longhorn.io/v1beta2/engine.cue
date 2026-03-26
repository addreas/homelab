package v1beta2

#Engine: {
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

	// EngineSpec defines the desired state of the Longhorn engine
	spec?: {
		active?:          bool
		backupVolume?:    string
		dataEngine?:      "v1" | "v2"
		desireState?:     string
		disableFrontend?: bool
		frontend?:        "blockdev" | "iscsi" | "nvmf" | "ublk" | ""
		image?:           string
		logRequested?:    bool
		nodeID?:          string

		// RebuildConcurrentSyncLimit controls the maximum number of file
		// synchronization operations that can run
		// concurrently during a single replica rebuild.
		// It is determined by the global setting or the volume spec field
		// with the same name.
		rebuildConcurrentSyncLimit?: int & <=5 & >=0
		replicaAddressMap?: [string]: string
		requestedBackupRestore?:  string
		requestedDataSource?:     string
		revisionCounterDisabled?: bool
		salvageRequested?:        bool
		snapshotMaxCount?:        int
		snapshotMaxSize?:         string

		// ublkNumberOfQueue controls the number of queues for ublk
		// frontend.
		ublkNumberOfQueue?: int

		// ublkQueueDepth controls the depth of each queue for ublk
		// frontend.
		ublkQueueDepth?:                   int
		unmapMarkSnapChainRemovedEnabled?: bool
		upgradedReplicaAddressMap?: [string]: string
		volumeName?: string
		volumeSize?: string
	}

	// EngineStatus defines the observed state of the Longhorn engine
	status?: {
		backupStatus?:
			null | {
				[string]: {
					backupURL?:      string
					error?:          string
					progress?:       int
					replicaAddress?: string
					snapshotName?:   string
					state?:          string
				}
			}
		cloneStatus?:
			null | {
				[string]: {
					error?:              string
					fromReplicaAddress?: string
					isCloning?:          bool
					progress?:           int
					snapshotName?:       string
					state?:              string
				}
			}
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
		currentImage?: string
		currentReplicaAddressMap?:
			null | {
				[string]: string
			}
		currentSize?:           string
		currentState?:          string
		endpoint?:              string
		instanceManagerName?:   string
		ip?:                    string
		isExpanding?:           bool
		lastExpansionError?:    string
		lastExpansionFailedAt?: string
		lastRestoredBackup?:    string
		logFetched?:            bool
		ownerID?:               string
		port?:                  int
		purgeStatus?:
			null | {
				[string]: {
					error?:     string
					isPurging?: bool
					progress?:  int
					state?:     string
				}
			}

		// RebuildConcurrentSyncLimit controls the maximum number of file
		// synchronization operations that can run
		// concurrently during a single replica rebuild.
		// It is determined by the global setting or the volume spec field
		// with the same name.
		rebuildConcurrentSyncLimit?: int & >=0
		rebuildStatus?:
			null | {
				[string]: {
					appliedRebuildingMBps?: int64 & int
					error?:                 string

					// Deprecated. We are now using FromReplicaAddressList to list all
					// source replicas.
					fromReplicaAddress?: string
					fromReplicaAddressList?: [...string]
					isRebuilding?: bool
					progress?:     int
					state?:        string
				}
			}
		replicaModeMap?:
			null | {
				[string]: string
			}

		// ReplicaTransitionTimeMap records the time a replica in
		// ReplicaModeMap transitions from one mode to another (or
		// from not being in the ReplicaModeMap to being in it). This
		// information is sometimes required by other controllers
		// (e.g. the volume controller uses it to determine the correct
		// value for replica.Spec.lastHealthyAt).
		replicaTransitionTimeMap?: [string]: string
		restoreStatus?:
			null | {
				[string]: {
					backupURL?:              string
					currentRestoringBackup?: string
					error?:                  string
					filename?:               string
					isRestoring?:            bool
					lastRestored?:           string
					progress?:               int
					state?:                  string
				}
			}
		salvageExecuted?:  bool
		snapshotMaxCount?: int
		snapshotMaxSize?:  string
		snapshots?:
			null | {
				[string]: {
					children?:
						null | {
							[string]: bool
						}
					created?: string
					labels?:
						null | {
							[string]: string
						}
					name?:        string
					parent?:      string
					removed?:     bool
					size?:        string
					usercreated?: bool
				}
			}
		snapshotsError?:                   string
		started?:                          bool
		starting?:                         bool
		storageIP?:                        string
		ublkID?:                           int32 & int
		unmapMarkSnapChainRemovedEnabled?: bool
		uuid?:                             string
	}

	_embeddedResource: {
		apiVersion!: string
		kind!:       string
		metadata?: {
			...
		}
	}
	apiVersion: "longhorn.io/v1beta2"
	kind:       "Engine"
	metadata!: {
		name!:      string
		namespace!: string
		labels?: [string]: string
		annotations?: [string]: string
		...
	}
}
