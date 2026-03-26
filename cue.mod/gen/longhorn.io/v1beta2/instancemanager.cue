package v1beta2

#InstanceManager: {
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

	// InstanceManagerSpec defines the desired state of the Longhorn
	// instance manager
	spec?: {
		dataEngine?: string
		dataEngineSpec?: v2?: cpuMask?: string
		image?:  string
		nodeID?: string
		type?:   "aio" | "engine" | "replica"
	}

	// InstanceManagerStatus defines the observed state of the
	// Longhorn instance manager
	status?: {
		apiMinVersion?: int
		apiVersion?:    int
		backingImages?:
			null | {
				[string]: {
					currentChecksum?: string
					diskUUID?:        string
					message?:         string
					name?:            string
					progress?:        int
					size?:            int64 & int
					state?:           string
					uuid?:            string
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
		currentState?: string
		dataEngineStatus?: v2?: {
			cpuMask?: string

			// InterruptModeEnabled indicates whether the V2 data engine is
			// running in
			// interrupt mode (true) or polling mode (false). Set by Longhorn
			// manager;
			// read-only to users.
			interruptModeEnabled?: "" | "true" | "false"
		}
		instanceEngines?:
			null | {
				[string]: {
					spec?: {
						dataEngine?: string
						name?:       string
					}
					status?: {
						conditions?:
							null | {
								[string]: bool
							}
						endpoint?:        string
						errorMsg?:        string
						listen?:          string
						portEnd?:         int32 & int
						portStart?:       int32 & int
						resourceVersion?: int64 & int
						state?:           string
						targetPortEnd?:   int32 & int
						targetPortStart?: int32 & int
						type?:            string
						ublkID?:          int32 & int
						uuid?:            string
					}
				}
			}
		instanceReplicas?:
			null | {
				[string]: {
					spec?: {
						dataEngine?: string
						name?:       string
					}
					status?: {
						conditions?:
							null | {
								[string]: bool
							}
						endpoint?:        string
						errorMsg?:        string
						listen?:          string
						portEnd?:         int32 & int
						portStart?:       int32 & int
						resourceVersion?: int64 & int
						state?:           string
						targetPortEnd?:   int32 & int
						targetPortStart?: int32 & int
						type?:            string
						ublkID?:          int32 & int
						uuid?:            string
					}
				}
			}
		ip?:                 string
		ownerID?:            string
		proxyApiMinVersion?: int
		proxyApiVersion?:    int
	}

	_embeddedResource: {
		apiVersion!: string
		kind!:       string
		metadata?: {
			...
		}
	}
	apiVersion: "longhorn.io/v1beta2"
	kind:       "InstanceManager"
	metadata!: {
		name!:      string
		namespace!: string
		labels?: [string]: string
		annotations?: [string]: string
		...
	}
}
