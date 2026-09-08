package v1beta2

#Volume: {
	_embeddedResource

	// APIVersion defines the versioned schema of this representation of an object.
	// Servers should convert recognized schemas to the latest internal value, and
	// may reject unrecognized values.
	// More info:
	// https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#resources
	apiVersion?: string

	// Kind is a string value representing the REST resource this object represents.
	// Servers may infer this from the endpoint the client submits requests to.
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

		// BackupBlockSize indicate the block size to create backups. The block size is immutable.
		backupBlockSize?:         "2097152" | "16777216"
		backupCompressionMethod?: "none" | "lz4" | "gzip"

		// The backup target name that the volume will be backed up to or is synced.
		backupTargetName?: string
		cloneMode?:        "" | "full-copy" | "linked-clone"
		dataEngine?:       "v1" | "v2"

		// DataLayout declares the user's intended data layout (topology type,
		// protection mode, and EC parameters).
		// The entire struct is immutable after creation.
		dataLayout?: {
			// DataChunks is the number of data chunks (k) in the EC array.
			// Required when Type is sharded; must be 0 for replicated volumes.
			dataChunks?: int & >=0

			// Mode describes the specific data protection mechanism in use.
			// Empty for V1 volumes where no SPDK-level mode applies.
			mode?: "raid1" | "erasureCoding" | ""

			// ParityChunks is the number of parity chunks (m) in the EC array.
			// The volume tolerates up to m simultaneous disk failures.
			// Required when Type is sharded; must be 0 for replicated volumes.
			parityChunks?: int & >=0

			// StripSizeKB is the chunk size in KiB used by the EC bdev.
			// Must be a power of two in the range [4, 1024].
			// Required when Type is sharded; must be 0 for replicated volumes.
			stripSizeKB?: int & >=0

			// Type describes how volume data is distributed across nodes.
			type?: "replicated" | "sharded" | ""
		}
		dataLocality?:    "disabled" | "best-effort" | "strict-local"
		dataSource?:      string
		disableFrontend?: bool
		diskSelector?: [...string]
		encrypted?: bool

		// engineNodeID defines the node where the backend engine (target) runs.
		// If empty, falls back to NodeID.
		engineNodeID?: string

		// Setting that freezes the filesystem on the root partition before a snapshot is created.
		freezeFilesystemForSnapshot?: "ignored" | "enabled" | "disabled"
		fromBackup?:                  string
		frontend?:                    "blockdev" | "iscsi" | "nvmf" | "ublk" | ""
		image?:                       string
		lastAttachedBy?:              string
		migratable?:                  bool
		migrationNodeID?:             string

		// nodeID defines the node where the volume is attached (where the frontend initiator runs).
		nodeID?: string
		nodeSelector?: [...string]
		numberOfReplicas?: int

		// Specifies whether Longhorn should rebuild replicas while the detached volume is degraded.
		// - ignored: Use the global setting for offline replica rebuilding.
		// - enabled: Enable offline rebuilding for this volume, regardless of the global setting.
		// - disabled: Disable offline rebuilding for this volume, regardless of the global setting
		offlineRebuilding?: "ignored" | "disabled" | "enabled"

		// RebuildConcurrentSyncLimit controls the maximum number of file
		// synchronization operations that can run
		// concurrently during a single replica rebuild.
		// When set to 0, it means following the global setting.
		rebuildConcurrentSyncLimit?: int & <=5 & >=0
		replicaAutoBalance?:         "ignored" | "disabled" | "least-effort" | "best-effort"

		// Replica disk soft anti affinity of the volume. Set enabled to allow replicas
		// to be scheduled in the same disk.
		replicaDiskSoftAntiAffinity?: "ignored" | "enabled" | "disabled"

		// ReplicaRebuildingBandwidthLimit controls the maximum write bandwidth (in
		// megabytes per second) allowed on the destination replica during the
		// rebuilding process. Set this value to 0 to disable bandwidth limiting.
		replicaRebuildingBandwidthLimit?: int64 & int & >=0

		// Replica soft anti affinity of the volume. Set enabled to allow replicas to be
		// scheduled on the same node.
		replicaSoftAntiAffinity?: "ignored" | "enabled" | "disabled"

		// Replica zone soft anti affinity of the volume. Set enabled to allow replicas
		// to be scheduled in the same zone.
		replicaZoneSoftAntiAffinity?: "ignored" | "enabled" | "disabled"
		restoreVolumeRecurringJob?:   "ignored" | "enabled" | "disabled"
		revisionCounterDisabled?:     bool
		size?:                        string
		snapshotDataIntegrity?:       "ignored" | "disabled" | "enabled" | "fast-check"

		// SnapshotHashingRequestedAt is the RFC3339 timestamp (e.g.,
		// "2026-03-16T10:30:00Z") when an on-demand snapshot checksum calculation is
		// requested.
		// When this value is set and is later than
		// LastOnDemandSnapshotHashingCompleteAt, the system will calculate checksums
		// for all user snapshots.
		//
		// If SnapshotHashingRequestedAt differs from
		// LastOnDemandSnapshotHashingCompleteAt, it indicates that a hashing request
		// is still in progress, and a new request will be rejected.
		snapshotHashingRequestedAt?: string
		snapshotMaxCount?:           int
		snapshotMaxSize?:            string
		staleReplicaTimeout?:        int

		// ublkNumberOfQueue controls the number of queues for ublk frontend.
		ublkNumberOfQueue?: int

		// ublkQueueDepth controls the depth of each queue for ublk frontend.
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

				// Last time the condition transitioned from one status to another.
				lastTransitionTime?: string

				// Human-readable message indicating details about last transition.
				message?: string

				// Unique, one-word, CamelCase reason for the condition's last transition.
				reason?: string

				// Status is the status of the condition.
				// Can be True, False, Unknown.
				status?: string

				// Type is the type of the condition.
				type?: string
			}]

		// the node that the engine (target) is currently running on.
		currentEngineNodeID?: string
		currentImage?:        string

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
		lastAutoSalvagedAt?: string
		lastBackup?:         string
		lastBackupAt?:       string
		lastDegradedAt?:     string

		// LastOnDemandSnapshotHashingCompleteAt is the RFC3339 timestamp (e.g.,
		// "2026-03-16T10:30:00Z") when the
		// most recent on-demand snapshot checksum calculation completed.
		// When this value matches SnapshotHashingRequestedAt, the requested on-demand
		// checksum calculation is considered complete.
		lastOnDemandSnapshotHashingCompleteAt?: string
		ownerID?:                               string
		remountRequestedAt?:                    string
		restoreInitiated?:                      bool
		restoreRequired?:                       bool
		robustness?:                            string
		shareEndpoint?:                         string
		shareState?:                            string
		state?:                                 string

		// SwitchoverState describes the current progress of a v2 engine live switchover.
		// Empty when no switchover is in progress.
		switchoverState?: string
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
