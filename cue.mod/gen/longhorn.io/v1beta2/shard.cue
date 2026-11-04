package v1beta2

#Shard: {
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

	// ShardSpec defines the desired state of the Longhorn Shard
	spec?: {
		// DiskPath is the path of the disk that hosts the shard lvol.
		diskPath?: string

		// DiskUUID is the UUID of the disk that hosts the shard lvol.
		diskUUID?: string

		// EvictionRequested indicates this shard should be relocated to a different node or disk.
		// Set by the node controller when the shard's node is being drained or its disk is evicted.
		evictionRequested?: bool

		// NodeID is the node where this shard's lvol resides and its NVMe-oF target runs.
		nodeID?: string

		// ShardGroupName is the name of the owning ShardGroup CR. Immutable after creation.
		shardGroupName?: string

		// Size is the shard lvol size in bytes. Set by the ShardGroup controller at creation time
		// and used for idempotent reconciliation.
		size?: string

		// SlotIndex is the zero-based position of this shard in the EC base-bdev array.
		// Determines the shard's role: indices 0..k-1 are DATA, k..k+m-1 are PARITY.
		// Immutable after creation.
		slotIndex?: int & >=0
	}

	// ShardStatus defines the observed state of the Longhorn Shard
	status?: {
		// LastFailureTimestamp is the RFC3339 timestamp of the most recent shard failure.
		lastFailureTimestamp?: string

		// OwnerID is the ID of the node that owns this Shard.
		ownerID?: string

		// Port is the NVMe-oF port of the shard's target export.
		port?: int32 & int

		// RebuildProgress is the rebuild completion percentage (0-100).
		rebuildProgress?: int

		// ReplaceTriggered is set to true after shard replacement has been initiated, to prevent
		// re-issuing the replace command on subsequent cycles while SPDK advances the slot state.
		// Cleared when the slot state transitions away from Failed.
		replaceTriggered?: bool

		// Role is the EC role of this slot (data or parity). Derived from SlotIndex and the parent
		// ShardGroup's DataChunks; stored here for informational purposes only.
		role?: "data" | "parity" | ""

		// State is the health state of this EC shard slot.
		state?: "normal" | "failed" | "replacing" | ""

		// StorageIP is the IP address of the NVMe-oF target exported by the shard's InstanceManager.
		// Populated after the shard instance is running.
		storageIP?: string
	}

	_embeddedResource: {
		apiVersion!: string
		kind!:       string
		metadata?: {
			...
		}
	}
	apiVersion: "longhorn.io/v1beta2"
	kind:       "Shard"
	metadata!: {
		name!:      string
		namespace!: string
		labels?: [string]: string
		annotations?: [string]: string
		...
	}
}
