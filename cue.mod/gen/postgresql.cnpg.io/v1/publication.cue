package v1

import "list"

#Publication: {
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

	// PublicationSpec defines the desired state of Publication
	spec!: {
		// The name of the PostgreSQL cluster that identifies the
		// "publisher"
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
		// the "publisher" cluster
		dbname!: string

		// The name of the publication inside PostgreSQL
		name!: string

		// Publication parameters part of the `WITH` clause as expected by
		// PostgreSQL `CREATE PUBLICATION` command
		parameters?: [string]: string

		// The policy for end-of-life maintenance of this publication
		publicationReclaimPolicy?: "delete" | "retain"

		// Target of the publication as expected by PostgreSQL `CREATE
		// PUBLICATION` command
		target!: {
			// Marks the publication as one that replicates changes for all
			// tables
			// in the database, including tables created in the future.
			// Corresponding to `FOR ALL TABLES` in PostgreSQL.
			allTables?: bool

			// Just the following schema objects
			objects?: list.MaxItems(100000) & [...{
				// Specifies a list of tables to add to the publication.
				// Corresponding
				// to `FOR TABLE` in PostgreSQL.
				table?: {
					// The columns to publish
					columns?: [...string]

					// The table name
					name!: string

					// Whether to limit to the table only or include all its
					// descendants
					only?: bool

					// The schema name
					schema?: string
				}

				// Marks the publication as one that replicates changes for all
				// tables
				// in the specified list of schemas, including tables created in
				// the
				// future. Corresponding to `FOR TABLES IN SCHEMA` in PostgreSQL.
				tablesInSchema?: string
			}]
		}
	}

	// PublicationStatus defines the observed state of Publication
	status?: {
		// Applied is true if the publication was reconciled correctly
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
	kind:       "Publication"
	metadata!: {
		name!:      string
		namespace!: string
		labels?: [string]: string
		annotations?: [string]: string
		...
	}
}
