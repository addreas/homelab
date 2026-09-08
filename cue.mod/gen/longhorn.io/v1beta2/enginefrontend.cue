package v1beta2

#EngineFrontend: {
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

	// EngineFrontendSpec defines the desired state of the Longhorn engine frontend (v2 initiator)
	spec?: {
		active?:          bool
		dataEngine?:      "v1" | "v2"
		desireState?:     string
		disableFrontend?: bool

		// EngineName is the name of the v2 engine target (required for EngineFrontend instance creation)
		engineName?:       string
		frontend?:         "blockdev" | "iscsi" | "nvmf" | "ublk" | ""
		image?:            string
		logRequested?:     bool
		nodeID?:           string
		salvageRequested?: bool

		// Size is the desired size of the frontend device in bytes, as requested
		// by the volume owner. The EngineFrontend controller drives the frontend
		// device toward this size independently of the engine's target size.
		size?: string

		// TargetIP is the IP address of the v2 engine target
		targetIP?: string

		// TargetPort is the port of the v2 engine target
		targetPort?: int

		// ublkNumberOfQueue controls the number of queues for ublk frontend.
		ublkNumberOfQueue?: int

		// ublkQueueDepth controls the depth of each queue for ublk frontend.
		ublkQueueDepth?: int
		volumeName?:     string
		volumeSize?:     string
	}

	// EngineFrontendStatus defines the observed state of the Longhorn engine frontend
	status?: {
		// ActivePath is the currently active frontend path address.
		activePath?: string
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
		currentImage?: string

		// CurrentSize is the current size of the frontend device in bytes, as
		// observed from the data plane. It is 0 while the engine frontend is not
		// running.
		currentSize?:  string
		currentState?: string

		// Endpoint is the initiator endpoint (e.g., /dev/longhorn/vol-name)
		endpoint?:            string
		instanceManagerName?: string
		ip?:                  string
		logFetched?:          bool
		ownerID?:             string

		// Paths describes the currently known frontend multipath state.
		paths?: [...{
			anaState?:   string
			engineName?: string
			nguid?:      string
			nqn?:        string
			targetIP?:   string
			targetPort?: int
		}]
		port?: int

		// PreferredPath is the preferred frontend path address.
		preferredPath?:   string
		salvageExecuted?: bool
		started?:         bool
		starting?:        bool
		storageIP?:       string

		// SwitchoverPhase is the last completed switchover phase reported by the data plane.
		switchoverPhase?: string

		// TargetIP is the currently connected IP address of the v2 engine target
		targetIP?: string

		// TargetPort is the currently connected port of the v2 engine target
		targetPort?: int
		ublkID?:     int32 & int
		uuid?:       string
	}

	_embeddedResource: {
		apiVersion!: string
		kind!:       string
		metadata?: {
			...
		}
	}
	apiVersion: "longhorn.io/v1beta2"
	kind:       "EngineFrontend"
	metadata!: {
		name!:      string
		namespace!: string
		labels?: [string]: string
		annotations?: [string]: string
		...
	}
}
