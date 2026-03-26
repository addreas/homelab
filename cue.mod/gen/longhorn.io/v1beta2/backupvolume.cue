package v1beta2

import "time"

#BackupVolume: {
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

	// BackupVolumeSpec defines the desired state of the Longhorn
	// backup volume
	spec?: {
		// The backup target name that the backup volume was synced.
		backupTargetName?:
			null | string

		// The time to request run sync the remote backup volume.
		syncRequestedAt?:
			null | time.Time

		// The volume name that the backup volume was used to backup.
		volumeName?: string
	}

	// BackupVolumeStatus defines the observed state of the Longhorn
	// backup volume
	status?: {
		// the backing image checksum.
		backingImageChecksum?: string

		// The backing image name.
		backingImageName?: string

		// The backup volume creation time.
		createdAt?: string

		// The backup volume block count.
		dataStored?: string

		// The backup volume labels.
		labels?:
			null | {
				[string]: string
			}

		// The latest volume backup time.
		lastBackupAt?: string

		// The latest volume backup name.
		lastBackupName?: string

		// The backup volume config last modification time.
		lastModificationTime?:
			null | time.Time

		// The last time that the backup volume was synced into the
		// cluster.
		lastSyncedAt?:
			null | time.Time

		// The error messages when call longhorn engine on list or inspect
		// backup volumes.
		messages?:
			null | {
				[string]: string
			}

		// The node ID on which the controller is responsible to reconcile
		// this backup volume CR.
		ownerID?: string

		// The backup volume size.
		size?: string

		// the storage class name of pv/pvc binding with the volume.
		storageClassName?: string
	}

	_embeddedResource: {
		apiVersion!: string
		kind!:       string
		metadata?: {
			...
		}
	}
	apiVersion: "longhorn.io/v1beta2"
	kind:       "BackupVolume"
	metadata!: {
		name!:      string
		namespace!: string
		labels?: [string]: string
		annotations?: [string]: string
		...
	}
}
