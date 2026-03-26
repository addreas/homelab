package v1

#Subscription: {
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
	metadata!: {}

	// SubscriptionSpec defines the desired state of Subscription
	spec!: {
		// The name of the PostgreSQL cluster that identifies the
		// "subscriber"
		cluster!: {
			// Name of the referent.
			// This field is effectively required, but due to backwards
			// compatibility is
			// allowed to be empty. Instances of this type with an empty value
			// here are
			// almost certainly wrong.
			// More info:
			// https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names
			name?: string
		}

		// The name of the database where the publication will be
		// installed in
		// the "subscriber" cluster
		dbname!: string

		// The name of the external cluster with the publication
		// ("publisher")
		externalClusterName!: string

		// The name of the subscription inside PostgreSQL
		name!: string

		// Subscription parameters included in the `WITH` clause of the
		// PostgreSQL
		// `CREATE SUBSCRIPTION` command. Most parameters cannot be
		// changed
		// after the subscription is created and will be ignored if
		// modified
		// later, except for a limited set documented at:
		// https://www.postgresql.org/docs/current/sql-altersubscription.html#SQL-ALTERSUBSCRIPTION-PARAMS-SET
		parameters?: [string]: string

		// The name of the database containing the publication on the
		// external
		// cluster. Defaults to the one in the external cluster
		// definition.
		publicationDBName?: string

		// The name of the publication inside the PostgreSQL database in
		// the
		// "publisher"
		publicationName!: string

		// The policy for end-of-life maintenance of this subscription
		subscriptionReclaimPolicy?: "delete" | "retain"
	}

	// SubscriptionStatus defines the observed state of Subscription
	status?: {
		// Applied is true if the subscription was reconciled correctly
		applied?: bool

		// Message is the reconciliation output message
		message?: string

		// A sequence number representing the latest
		// desired state that was synchronized
		observedGeneration?: int64 & int
	}

	_embeddedResource: {
		apiVersion!: string
		kind!:       string
		metadata?: {
			...
		}
	}
	apiVersion: "postgresql.cnpg.io/v1"
	kind:       "Subscription"
	metadata!: {
		name!:      string
		namespace!: string
		labels?: [string]: string
		annotations?: [string]: string
		...
	}
}
