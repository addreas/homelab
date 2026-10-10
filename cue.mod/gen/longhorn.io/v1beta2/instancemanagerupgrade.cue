package v1beta2

#InstanceManagerUpgrade: {
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

	// InstanceManagerUpgradeSpec defines the desired state of the InstanceManagerUpgrade.
	spec?: {
		// NodeID is the node where the source instance manager is running.
		nodeID!: string

		// TargetImage is the desired instance manager image after upgrade.
		targetImage!: string
	}

	// InstanceManagerUpgradeStatus defines the observed state of the InstanceManagerUpgrade.
	status?: {
		// AbortReason explains why AbortRequested was set.
		abortReason?: string

		// AbortRequested is set by the controller when an abort condition is detected.
		abortRequested?: bool

		// Conditions records the current conditions of the upgrade.
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

		// Engines records the relocation plan for each engine managed by the source
		// instance manager. The map key is the volume name.
		engines?:
			null | {
				[string]: {
					// OriginalNodeID is the node where the engine was originally running.
					originalNodeID!: string

					// TemporaryNodeID is the node the engine is temporarily relocated to while
					// the source instance manager is being upgraded.
					temporaryNodeID?: string
				}
			}

		// ErrorMsg records the terminal error encountered during the upgrade, if any.
		errorMsg?: string

		// OwnerID is the owner node ID of this InstanceManagerUpgrade.
		ownerID?: string

		// PlannedDetachedReplicas records the replicas that should be temporarily
		// detached from engines during the instance manager upgrade. The map key is
		// the volume name.
		plannedDetachedReplicas?:
			null | {
				[string]: [...{
					// Address is the raw replica backend address recorded when the detach plan
					// is created.
					address!: string

					// Name is the replica name.
					name!: string
				}]
			}

		// StartedAt records when the timed or active portion of the upgrade began.
		startedAt?: string

		// State indicates the overall progress of the instance manager upgrade.
		state?: string
	}

	_embeddedResource: {
		apiVersion!: string
		kind!:       string
		metadata?: {
			...
		}
	}
	apiVersion: "longhorn.io/v1beta2"
	kind:       "InstanceManagerUpgrade"
	metadata!: {
		name!:      string
		namespace!: string
		labels?: [string]: string
		annotations?: [string]: string
		...
	}
}
