package v1beta2

#VolumeAttachment: {
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

	// VolumeAttachmentSpec defines the desired state of Longhorn
	// VolumeAttachment
	spec?: {
		attachmentTickets?: [string]: {
			// A sequence number representing a specific generation of the
			// desired state.
			// Populated by the system. Read-only.
			generation?: int64 & int

			// The unique ID of this attachment. Used to differentiate
			// different attachments of the same volume.
			id?: string

			// The node that this attachment is requesting
			nodeID?: string

			// Optional additional parameter for this attachment
			parameters?: [string]: string
			type?: string
		}

		// The name of Longhorn volume of this VolumeAttachment
		volume!: string
	}

	// VolumeAttachmentStatus defines the observed state of Longhorn
	// VolumeAttachment
	status?: attachmentTicketStatuses?: [string]: {
		// Record any error when trying to fulfill this attachment
		conditions!:
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

		// A sequence number representing a specific generation of the
		// desired state.
		// Populated by the system. Read-only.
		generation?: int64 & int

		// The unique ID of this attachment. Used to differentiate
		// different attachments of the same volume.
		id?: string

		// Indicate whether this attachment ticket has been satisfied
		satisfied!: bool
	}

	_embeddedResource: {
		apiVersion!: string
		kind!:       string
		metadata?: {
			...
		}
	}
	apiVersion: "longhorn.io/v1beta2"
	kind:       "VolumeAttachment"
	metadata!: {
		name!:      string
		namespace!: string
		labels?: [string]: string
		annotations?: [string]: string
		...
	}
}
