package v1beta2

#RecurringJob: {
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

	// RecurringJobSpec defines the desired state of the Longhorn recurring job
	spec?: {
		// The concurrency of taking the snapshot/backup.
		concurrency?: int

		// The cron setting.
		cron?: string

		// The recurring job group.
		groups?: [...string]

		// The label of the snapshot/backup.
		labels?: [string]: string

		// The recurring job name.
		name?: string

		// The parameters of the snapshot/backup.
		// Support parameters: "full-backup-interval", "volume-backup-policy".
		parameters?: [string]: string

		// The retain count of the snapshot/backup.
		// Retain represents the number of snapshots/backups to retain and only when the
		// retention policy is "count-based".
		retain?: int

		// The retention age of the snapshot/backup, specified as a Go duration string,
		// such as "10m", "24h", or "8760h". Note that Go durations have no day or year unit,
		// so a day is "24h". Snapshots/backups older than this are cleaned up by the recurring job.
		// Only takes effect when the retention policy is "age-based".
		// If the retention policy is "age-based", this value is 0s, the recurring job will not start.
		retainAge?: string

		// The retention policy that determines whether the recurring job cleans up
		// snapshots/backups based on their count or age. Can be "count-based" or
		// "age-based". The two policies work independently: "count-based" (the default)
		// retains the configured number of newest snapshots/backups and ignores
		// RetainAge, while "age-based" retains snapshots/backups no older than RetainAge
		// and ignores Retain.
		retentionPolicy?: "count-based" | "age-based"

		// The recurring job task.
		// Can be "snapshot", "snapshot-force-create", "snapshot-cleanup",
		// "snapshot-delete", "backup", "backup-force-create", "filesystem-trim" or
		// "system-backup".
		task?: "snapshot" | "snapshot-force-create" | "snapshot-cleanup" | "snapshot-delete" | "backup" | "backup-force-create" | "filesystem-trim" | "system-backup"
	}

	// RecurringJobStatus defines the observed state of the Longhorn recurring job
	status?: {
		// The number of jobs that have been triggered.
		executionCount?: int

		// The owner ID which is responsible to reconcile this recurring job CR.
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
	kind:       "RecurringJob"
	metadata!: {
		name!:      string
		namespace!: string
		labels?: [string]: string
		annotations?: [string]: string
		...
	}
}
