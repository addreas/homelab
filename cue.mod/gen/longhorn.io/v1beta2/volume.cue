package v1beta2

#Volume: {
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

	// VolumeSpec defines the desired state of the Longhorn volume
	spec?: {
		Standby?:      bool
		accessMode?:   "rwo" | "rwop" | "rwx"
		backingImage?: string

		// BackupBlockSize indicate the block size to create backups. The
		// block size is immutable.
		backupBlockSize?:         "2097152" | "16777216"
		backupCompressionMethod?: "none" | "lz4" | "gzip"

		// The backup target name that the volume will be backed up to or
		// is synced.
		backupTargetName?: string
		cloneMode?:        "" | "full-copy" | "linked-clone"
		dataEngine?:       "v1" | "v2"
		dataLocality?:     "disabled" | "best-effort" | "strict-local"
		dataSource?:       string
		disableFrontend?:  bool
		diskSelector?: [...string]
		encrypted?: bool

		// Setting that freezes the filesystem on the root partition
		// before a snapshot is created.
		freezeFilesystemForSnapshot?: "ignored" | "enabled" | "disabled"
		fromBackup?:                  string
		frontend?:                    "blockdev" | "iscsi" | "nvmf" | "ublk" | ""
		image?:                       string
		lastAttachedBy?:              string
		migratable?:                  bool
		migrationNodeID?:             string
		nodeID?:                      string
		nodeSelector?: [...string]
		numberOfReplicas?: int

		// Specifies whether Longhorn should rebuild replicas while the
		// detached volume is degraded.
		// - ignored: Use the global setting for offline replica
		// rebuilding.
		// - enabled: Enable offline rebuilding for this volume,
		// regardless of the global setting.
		// - disabled: Disable offline rebuilding for this volume,
		// regardless of the global setting
		offlineRebuilding?: "ignored" | "disabled" | "enabled"

		// RebuildConcurrentSyncLimit controls the maximum number of file
		// synchronization operations that can run
		// concurrently during a single replica rebuild.
		// When set to 0, it means following the global setting.
		rebuildConcurrentSyncLimit?: int & <=5 & >=0
		replicaAutoBalance?:         "ignored" | "disabled" | "least-effort" | "best-effort"

		// Replica disk soft anti affinity of the volume. Set enabled to
		// allow replicas to be scheduled in the same disk.
		replicaDiskSoftAntiAffinity?: "ignored" | "enabled" | "disabled"

		// ReplicaRebuildingBandwidthLimit controls the maximum write
		// bandwidth (in megabytes per second) allowed on the destination
		// replica during the rebuilding process. Set this value to 0 to
		// disable bandwidth limiting.
		replicaRebuildingBandwidthLimit?: int64 & int & >=0

		// Replica soft anti affinity of the volume. Set enabled to allow
		// replicas to be scheduled on the same node.
		replicaSoftAntiAffinity?: "ignored" | "enabled" | "disabled"

		// Replica zone soft anti affinity of the volume. Set enabled to
		// allow replicas to be scheduled in the same zone.
		replicaZoneSoftAntiAffinity?: "ignored" | "enabled" | "disabled"
		restoreVolumeRecurringJob?:   "ignored" | "enabled" | "disabled"
		revisionCounterDisabled?:     bool
		size?:                        string
		snapshotDataIntegrity?:       "ignored" | "disabled" | "enabled" | "fast-check"
		snapshotMaxCount?:            int
		snapshotMaxSize?:             string
		staleReplicaTimeout?:         int

		// ublkNumberOfQueue controls the number of queues for ublk
		// frontend.
		ublkNumberOfQueue?: int

		// ublkQueueDepth controls the depth of each queue for ublk
		// frontend.
		ublkQueueDepth?:            int
		unmapMarkSnapChainRemoved?: "ignored" | "disabled" | "enabled"
	}

	// VolumeStatus defines the observed state of the Longhorn volume
	status?: {
		actualSize?: int64 & int
		cloneStatus?: {
			attemptCount?:         int
			nextAllowedAttemptAt?: string
			snapshot?:             string
			sourceVolume?:         string
			state?:                string
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

		// the node that this volume is currently migrating to
		currentMigrationNodeID?: string
		currentNodeID?:          string
		expansionRequired?:      bool
		frontendDisabled?:       bool
		isStandby?:              bool
		kubernetesStatus?: {
			lastPVCRefAt?: string
			lastPodRefAt?: string

			// determine if PVC/Namespace is history or not
			namespace?: string
			pvName?:    string
			pvStatus?:  string
			pvcName?:   string

			// determine if Pod/Workload is history or not
			workloadsStatus?:
				null | [...{
					podName?:      string
					podStatus?:    string
					workloadName?: string
					workloadType?: string
				}]
		}
		lastBackup?:         string
		lastBackupAt?:       string
		lastDegradedAt?:     string
		ownerID?:            string
		remountRequestedAt?: string
		restoreInitiated?:   bool
		restoreRequired?:    bool
		robustness?:         string
		shareEndpoint?:      string
		shareState?:         string
		state?:              string
	}

	_embeddedResource: {
		apiVersion!: string
		kind!:       string
		metadata?: {
			...
		}
	}
	apiVersion: "longhorn.io/v1beta2"
	kind:       "Volume"
	metadata!: {
		name!:      string
		namespace!: string
		labels?: [string]: string
		annotations?: [string]: string
		...
	}
}
