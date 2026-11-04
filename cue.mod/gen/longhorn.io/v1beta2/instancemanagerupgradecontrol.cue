package v1beta2

#InstanceManagerUpgradeControl: {
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

	// InstanceManagerUpgradeControlSpec defines the desired state of the
	// InstanceManagerUpgradeControl singleton.
	spec?: {
		// StartAt is the RFC3339 timestamp at which the upgrade cycle should begin.
		startAt?: string

		// TargetImage is the desired instance manager image for all nodes.
		targetImage?: string
	}

	// InstanceManagerUpgradeControlStatus defines the observed state of the
	// InstanceManagerUpgradeControl.
	status?: {
		// CurrentNode is the name of the node that is actively being upgraded.
		currentNode?: string

		// Nodes holds the upgrade status for nodes participating in the current or
		// most recent upgrade cycle.
		nodes?:
			null | {
				[string]: {
					// CompletedAt is the RFC3339 timestamp when the upgrade finished on this node.
					completedAt?: string

					// ErrorMsg records the last error encountered while upgrading this node.
					errorMsg?: string

					// IMUName is the name of the InstanceManagerUpgrade CR created for this node.
					imuName?: string

					// RetryCount tracks how many times the upgrade has been attempted for this node.
					retryCount?: int

					// StartedAt is the RFC3339 timestamp when the upgrade began on this node.
					startedAt?: string

					// State is the current upgrade state for this node.
					state!: string
				}
			}

		// OwnerID is the ID of the Longhorn manager pod that currently owns this CR.
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
	kind:       "InstanceManagerUpgradeControl"
	metadata!: {
		name!:      string
		namespace!: string
		labels?: [string]: string
		annotations?: [string]: string
		...
	}
}
