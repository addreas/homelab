package v1beta2

#SnapshotGroup: {
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

	// SnapshotGroupSpec defines the desired state of the Longhorn SnapshotGroup.
	// The whole spec is immutable after creation: a group is a point-in-time
	// request, so changing members later has no meaning.
	spec?: {
		// DeadlineSeconds is the deadline for taking every member snapshot,
		// measured from the group's metadata.creationTimestamp. When the field is
		// omitted, the CRD default applies. Go clients cannot omit the field: an
		// unset field arrives as 0, and the mutating webhook replaces the 0 with
		// the default.
		deadlineSeconds?: int64 & int & <=3600 & >=10

		// Labels are engine snapshot labels applied to every member (Snapshot
		// spec.labels). They are not visible to Kubernetes label selectors.
		// Reserved recurring-job label keys are rejected at admission.
		labels?:
			null | {
				[string]: string
			}

		// Members is the fixed member set, resolved from Volumes or VolumeSelector
		// and stamped by the mutating webhook at admission. It may not be set by
		// the user.
		members?:
			null | [...{
				snapshotName!: string
				volumeName!:   string
			}]

		// VolumeSelector selects the member volumes by their labels. Exactly one of
		// Volumes or VolumeSelector may be set at creation.
		volumeSelector?: {
			// matchExpressions is a list of label selector requirements. The requirements are ANDed.
			matchExpressions?: [...{
				// key is the label key that the selector applies to.
				key!: string

				// operator represents a key's relationship to a set of values.
				// Valid operators are In, NotIn, Exists and DoesNotExist.
				operator!: string

				// values is an array of string values. If the operator is In or NotIn,
				// the values array must be non-empty. If the operator is Exists or DoesNotExist,
				// the values array must be empty. This array is replaced during a strategic
				// merge patch.
				values?: [...string]
			}]

			// matchLabels is a map of {key,value} pairs. A single {key,value} in the matchLabels
			// map is equivalent to an element of matchExpressions, whose key field is "key", the
			// operator is "In", and the values array contains only "value". The requirements are ANDed.
			matchLabels?: [string]: string
		}

		// Volumes explicitly lists the member volumes. Exactly one of Volumes or
		// VolumeSelector may be set at creation; the mutating webhook resolves the
		// selection into Members at admission.
		volumes?:
			null | [...string]
	}

	// SnapshotGroupStatus defines the observed state of the Longhorn SnapshotGroup
	status?: {
		// Conditions holds the latest observations of the SnapshotGroup's state,
		// such as Degraded.
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

		// CreationTime is the latest member creation time, set when the group
		// becomes Ready.
		creationTime?: string

		// Error is set when the group fails (deadline, name collision).
		error?: string

		// Members is the observed state of every member, one entry per spec
		// member. It is the primary debugging signal: each entry carries the
		// member's last error and creation time.
		members?:
			null | [...{
				// CreationTime is the engine snapshot creation time, mirrored from the
				// member Snapshot. It is kept when the member is later lost.
				creationTime?: string

				// Error is the last member error. A member Snapshot CR that disappeared
				// after the group became Ready is recorded with the synthetic error
				// "member snapshot deleted"; an unusable member keeps its own mirrored
				// error.
				error?: string

				// ReadyToUse mirrors the member Snapshot while the group is InProgress.
				// After the group is Ready, a member later deleted or unusable is recorded
				// here as false: member entries always tell the per-member truth.
				readyToUse?:   bool
				snapshotName!: string
				volumeName!:   string
			}]

		// OwnerID is the ID of the node that owns this SnapshotGroup.
		ownerID?: string

		// Phase is the lifecycle phase: empty until the first reconcile, then
		// InProgress -> Ready | Failed.
		phase?: "InProgress" | "Ready" | "Failed" | ""

		// ReadyToUse is true when the group is Ready and every member snapshot
		// is still individually ready: group readiness is the AND of member
		// readiness, following the Kubernetes VolumeGroupSnapshot convention. It
		// drops to false when a member is lost or unusable after Ready and
		// recovers once every member is whole again; the Degraded condition
		// carries the per-member detail. A failed, partial, or empty group is
		// never reported ready.
		readyToUse?: bool
	}

	_embeddedResource: {
		apiVersion!: string
		kind!:       string
		metadata?: {
			...
		}
	}
	apiVersion: "longhorn.io/v1beta2"
	kind:       "SnapshotGroup"
	metadata!: {
		name!:      string
		namespace!: string
		labels?: [string]: string
		annotations?: [string]: string
		...
	}
}
