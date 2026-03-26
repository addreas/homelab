package v1beta2

import "time"

#Backup: {
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

	// BackupSpec defines the desired state of the Longhorn backup
	spec?: {
		// The backup block size. 0 means the legacy default size 2MiB,
		// and -1 indicate the block size is invalid.
		backupBlockSize?: "-1" | "2097152" | "16777216"

		// The backup mode of this backup.
		// Can be "full" or "incremental"
		backupMode?: "full" | "incremental"

		// The labels of snapshot backup.
		labels?: [string]: string

		// The snapshot name.
		snapshotName?: string

		// The time to request run sync the remote backup.
		syncRequestedAt?:
			null | time.Time
	}

	// BackupStatus defines the observed state of the Longhorn backup
	status?: {
		// The snapshot backup upload finished time.
		backupCreatedAt?: string

		// The backup target name.
		backupTargetName?: string

		// Compression method
		compressionMethod?: string

		// The error message when taking the snapshot backup.
		error?: string

		// The labels of snapshot backup.
		labels?:
			null | {
				[string]: string
			}

		// The last time that the backup was synced with the remote backup
		// target.
		lastSyncedAt?:
			null | time.Time

		// The error messages when calling longhorn engine on listing or
		// inspecting backups.
		messages?:
			null | {
				[string]: string
			}

		// Size in bytes of newly uploaded data
		newlyUploadDataSize?: string

		// The node ID on which the controller is responsible to reconcile
		// this backup CR.
		ownerID?: string

		// The snapshot backup progress.
		progress?: int

		// Size in bytes of reuploaded data
		reUploadedDataSize?: string

		// The address of the replica that runs snapshot backup.
		replicaAddress?: string

		// The snapshot size.
		size?: string

		// The snapshot creation time.
		snapshotCreatedAt?: string

		// The snapshot name.
		snapshotName?: string

		// The backup creation state.
		// Can be "", "InProgress", "Completed", "Error", "Unknown".
		state?: string

		// The snapshot backup URL.
		url?: string

		// The volume's backing image name.
		volumeBackingImageName?: string

		// The volume creation time.
		volumeCreated?: string

		// The volume name.
		volumeName?: string

		// The volume size.
		volumeSize?: string
	}

	_embeddedResource: {
		apiVersion!: string
		kind!:       string
		metadata?: {
			...
		}
	}
	apiVersion: "longhorn.io/v1beta2"
	kind:       "Backup"
	metadata!: {
		name!:      string
		namespace!: string
		labels?: [string]: string
		annotations?: [string]: string
		...
	}
}
