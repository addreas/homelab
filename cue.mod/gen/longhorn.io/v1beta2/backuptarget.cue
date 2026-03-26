package v1beta2

import "time"

#BackupTarget: {
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

	// BackupTargetSpec defines the desired state of the Longhorn
	// backup target
	spec?: {
		// The backup target URL.
		backupTargetURL?: string

		// The backup target credential secret.
		credentialSecret?: string

		// The interval that the cluster needs to run sync with the backup
		// target.
		pollInterval?: string

		// The time to request run sync the remote backup target.
		syncRequestedAt?:
			null | time.Time
	}

	// BackupTargetStatus defines the observed state of the Longhorn
	// backup target
	status?: {
		// Available indicates if the remote backup target is available or
		// not.
		available?: bool

		// Records the reason on why the backup target is unavailable.
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

		// The last time that the controller synced with the remote backup
		// target.
		lastSyncedAt?:
			null | time.Time

		// The node ID on which the controller is responsible to reconcile
		// this backup target CR.
		ownerID?: string
	}

	_embeddedResource: {
		apiVersion!: string
		kind!:       string
		metadata?: {
			...
		}
	}
	apiVersion: "longhorn.io/v1beta2"
	kind:       "BackupTarget"
	metadata!: {
		name!:      string
		namespace!: string
		labels?: [string]: string
		annotations?: [string]: string
		...
	}
}
