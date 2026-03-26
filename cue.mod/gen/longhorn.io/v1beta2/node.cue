package v1beta2

import "time"

#Node: {
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

	// NodeSpec defines the desired state of the Longhorn node
	spec?: {
		allowScheduling?: bool
		disks?: [string]: {
			allowScheduling?:   bool
			diskDriver?:        "" | "auto" | "aio" | "nvme"
			diskType?:          "filesystem" | "block"
			evictionRequested?: bool
			path?:              string
			storageReserved?:   int64 & int
			tags?: [...string]
		}
		evictionRequested?:         bool
		instanceManagerCPURequest?: int
		name?:                      string
		tags?: [...string]
	}

	// NodeStatus defines the observed state of the Longhorn node
	status?: {
		autoEvicting?: bool
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
		diskStatus?:
			null | {
				[string]: {
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
					diskDriver?:     string
					diskName?:       string
					diskPath?:       string
					diskType?:       string
					diskUUID?:       string
					filesystemType?: string
					healthData?: [string]: {
						attributes?: [...{
							id?:         int
							name?:       string
							rawString?:  string
							rawValue?:   int64 & int
							threshold?:  int
							value?:      int
							whenFailed?: string
							worst?:      int
						}]
						capacity?:        int64 & int
						diskName?:        string
						diskType?:        string
						firmwareVersion?: string
						healthStatus?:    "FAILED" | "PASSED" | "UNKNOWN" | "WARNING"
						modelName?:       string
						serialNumber?:    string
						source?:          "SMART" | "SPDK"
						temperature?:     int
					}
					healthDataLastCollectedAt?: time.Time
					instanceManagerName?:       string
					scheduledBackingImage?:
						null | {
							[string]: int64 & int
						}
					scheduledReplica?:
						null | {
							[string]: int64 & int
						}
					storageAvailable?: int64 & int
					storageMaximum?:   int64 & int
					storageScheduled?: int64 & int
				}
			}
		region?: string
		snapshotCheckStatus?: lastPeriodicCheckedAt?: time.Time
		zone?: string
	}

	_embeddedResource: {
		apiVersion!: string
		kind!:       string
		metadata?: {
			...
		}
	}
	apiVersion: "longhorn.io/v1beta2"
	kind:       "Node"
	metadata!: {
		name!:      string
		namespace!: string
		labels?: [string]: string
		annotations?: [string]: string
		...
	}
}
