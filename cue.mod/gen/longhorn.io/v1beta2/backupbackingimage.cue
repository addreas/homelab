package v1beta2

import "time"

#BackupBackingImage: {
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

	// BackupBackingImageSpec defines the desired state of the
	// Longhorn backing image backup
	spec?: {
		// The backing image name.
		backingImage!: string

		// The backup target name.
		backupTargetName?:
			null | string

		// The labels of backing image backup.
		labels?: [string]: string

		// The time to request run sync the remote backing image backup.
		syncRequestedAt?:
			null | time.Time

		// Is this CR created by user through API or UI.
		userCreated!: bool
	}

	// BackupBackingImageStatus defines the observed state of the
	// Longhorn backing image backup
	status?: {
		// The backing image name.
		backingImage?: string

		// The backing image backup upload finished time.
		backupCreatedAt?: string

		// The checksum of the backing image.
		checksum?: string

		// Compression method
		compressionMethod?: string

		// The error message when taking the backing image backup.
		error?: string

		// The labels of backing image backup.
		labels?:
			null | {
				[string]: string
			}

		// The last time that the backing image backup was synced with the
		// remote backup target.
		lastSyncedAt?:
			null | time.Time

		// The address of the backing image manager that runs backing
		// image backup.
		managerAddress?: string

		// The error messages when listing or inspecting backing image
		// backup.
		messages?:
			null | {
				[string]: string
			}

		// The node ID on which the controller is responsible to reconcile
		// this CR.
		ownerID?: string

		// The backing image backup progress.
		progress?: int

		// Record the secret if this backup backing image is encrypted
		secret?: string

		// Record the secret namespace if this backup backing image is
		// encrypted
		secretNamespace?: string

		// The backing image size.
		size?: int64 & int

		// The backing image backup creation state.
		// Can be "", "InProgress", "Completed", "Error", "Unknown".
		state?: string

		// The backing image backup URL.
		url?: string
	}

	_embeddedResource: {
		apiVersion!: string
		kind!:       string
		metadata?: {
			...
		}
	}
	apiVersion: "longhorn.io/v1beta2"
	kind:       "BackupBackingImage"
	metadata!: {
		name!:      string
		namespace!: string
		labels?: [string]: string
		annotations?: [string]: string
		...
	}
}
