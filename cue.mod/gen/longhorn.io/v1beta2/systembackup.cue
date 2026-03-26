package v1beta2

import "time"

#SystemBackup: {
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

	// SystemBackupSpec defines the desired state of the Longhorn
	// SystemBackup
	spec?: {
		// The create volume backup policy
		// Can be "if-not-present", "always" or "disabled"
		volumeBackupPolicy?:
			null | string
	}

	// SystemBackupStatus defines the observed state of the Longhorn
	// SystemBackup
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

		// The system backup creation time.
		createdAt?: time.Time

		// The saved Longhorn manager git commit.
		gitCommit?:
			null | string

		// The last time that the system backup was synced into the
		// cluster.
		lastSyncedAt?:
			null | time.Time

		// The saved manager image.
		managerImage?: string

		// The node ID of the responsible controller to reconcile this
		// SystemBackup.
		ownerID?: string

		// The system backup state.
		state?: string

		// The saved Longhorn version.
		version?:
			null | string
	}

	_embeddedResource: {
		apiVersion!: string
		kind!:       string
		metadata?: {
			...
		}
	}
	apiVersion: "longhorn.io/v1beta2"
	kind:       "SystemBackup"
	metadata!: {
		name!:      string
		namespace!: string
		labels?: [string]: string
		annotations?: [string]: string
		...
	}
}
