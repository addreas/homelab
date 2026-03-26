package v1

#Database: {
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

	// Specification of the desired Database.
	// More info:
	// https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#spec-and-status
	spec!: {
		// Maps to the `ALLOW_CONNECTIONS` parameter of `CREATE DATABASE`
		// and
		// `ALTER DATABASE`. If false then no one can connect to this
		// database.
		allowConnections?: bool

		// Maps to the `BUILTIN_LOCALE` parameter of `CREATE DATABASE`.
		// This
		// setting cannot be changed. Specifies the locale name when the
		// builtin provider is used. This option requires `localeProvider`
		// to
		// be set to `builtin`. Available from PostgreSQL 17.
		builtinLocale?: string

		// The name of the PostgreSQL cluster hosting the database.
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

		// Maps to the `COLLATION_VERSION` parameter of `CREATE DATABASE`.
		// This
		// setting cannot be changed.
		collationVersion?: string

		// Maps to the `CONNECTION LIMIT` clause of `CREATE DATABASE` and
		// `ALTER DATABASE`. How many concurrent connections can be made
		// to
		// this database. -1 (the default) means no limit.
		connectionLimit?: int

		// The policy for end-of-life maintenance of this database.
		databaseReclaimPolicy?: "delete" | "retain"

		// Maps to the `ENCODING` parameter of `CREATE DATABASE`. This
		// setting
		// cannot be changed. Character set encoding to use in the
		// database.
		encoding?: string

		// Ensure the PostgreSQL database is `present` or `absent` -
		// defaults to "present".
		ensure?: "present" | "absent"

		// The list of extensions to be managed in the database
		extensions?: [...{
			// Specifies whether an object (e.g schema) should be present or
			// absent
			// in the database. If set to `present`, the object will be
			// created if
			// it does not exist. If set to `absent`, the extension/schema
			// will be
			// removed if it exists.
			ensure?: "present" | "absent"

			// Name of the object (extension, schema, FDW, server)
			name!: string

			// The name of the schema in which to install the extension's
			// objects,
			// in case the extension allows its contents to be relocated. If
			// not
			// specified (default), and the extension's control file does not
			// specify a schema either, the current default object creation
			// schema
			// is used.
			schema?: string

			// The version of the extension to install. If empty, the operator
			// will
			// install the default version (whatever is specified in the
			// extension's control file)
			version?: string
		}]

		// The list of foreign data wrappers to be managed in the database
		fdws?: [...{
			// Specifies whether an object (e.g schema) should be present or
			// absent
			// in the database. If set to `present`, the object will be
			// created if
			// it does not exist. If set to `absent`, the extension/schema
			// will be
			// removed if it exists.
			ensure?: "present" | "absent"

			// Name of the handler function (e.g., "postgres_fdw_handler").
			// This will be empty if no handler is specified. In that case,
			// the default handler is registered when the FDW extension is
			// created.
			handler?: string

			// Name of the object (extension, schema, FDW, server)
			name!: string

			// Options specifies the configuration options for the FDW.
			options?: [...{
				// Specifies whether an option should be present or absent in
				// the database. If set to `present`, the option will be
				// created if it does not exist. If set to `absent`, the
				// option will be removed if it exists.
				ensure?: "present" | "absent"

				// Name of the option
				name!: string

				// Value of the option
				value!: string
			}]

			// Owner specifies the database role that will own the Foreign
			// Data Wrapper.
			// The role must have superuser privileges in the target database.
			owner?: string

			// List of roles for which `USAGE` privileges on the FDW are
			// granted or revoked.
			usage?: [...{
				// Name of the usage
				name!: string

				// The type of usage
				type?: "grant" | "revoke"
			}]

			// Name of the validator function (e.g.,
			// "postgres_fdw_validator").
			// This will be empty if no validator is specified. In that case,
			// the default validator is registered when the FDW extension is
			// created.
			validator?: string
		}]

		// Maps to the `ICU_LOCALE` parameter of `CREATE DATABASE`. This
		// setting cannot be changed. Specifies the ICU locale when the
		// ICU
		// provider is used. This option requires `localeProvider` to be
		// set to
		// `icu`. Available from PostgreSQL 15.
		icuLocale?: string

		// Maps to the `ICU_RULES` parameter of `CREATE DATABASE`. This
		// setting
		// cannot be changed. Specifies additional collation rules to
		// customize
		// the behavior of the default collation. This option requires
		// `localeProvider` to be set to `icu`. Available from PostgreSQL
		// 16.
		icuRules?: string

		// Maps to the `IS_TEMPLATE` parameter of `CREATE DATABASE` and
		// `ALTER
		// DATABASE`. If true, this database is considered a template and
		// can
		// be cloned by any user with `CREATEDB` privileges.
		isTemplate?: bool

		// Maps to the `LOCALE` parameter of `CREATE DATABASE`. This
		// setting
		// cannot be changed. Sets the default collation order and
		// character
		// classification in the new database.
		locale?: string

		// Maps to the `LC_CTYPE` parameter of `CREATE DATABASE`. This
		// setting
		// cannot be changed.
		localeCType?: string

		// Maps to the `LC_COLLATE` parameter of `CREATE DATABASE`. This
		// setting cannot be changed.
		localeCollate?: string

		// Maps to the `LOCALE_PROVIDER` parameter of `CREATE DATABASE`.
		// This
		// setting cannot be changed. This option sets the locale provider
		// for
		// databases created in the new cluster. Available from PostgreSQL
		// 16.
		localeProvider?: string

		// The name of the database to create inside PostgreSQL. This
		// setting cannot be changed.
		name!: string

		// Maps to the `OWNER` parameter of `CREATE DATABASE`.
		// Maps to the `OWNER TO` command of `ALTER DATABASE`.
		// The role name of the user who owns the database inside
		// PostgreSQL.
		owner!: string

		// The list of schemas to be managed in the database
		schemas?: [...{
			// Specifies whether an object (e.g schema) should be present or
			// absent
			// in the database. If set to `present`, the object will be
			// created if
			// it does not exist. If set to `absent`, the extension/schema
			// will be
			// removed if it exists.
			ensure?: "present" | "absent"

			// Name of the object (extension, schema, FDW, server)
			name!: string

			// The role name of the user who owns the schema inside
			// PostgreSQL.
			// It maps to the `AUTHORIZATION` parameter of `CREATE SCHEMA` and
			// the
			// `OWNER TO` command of `ALTER SCHEMA`.
			owner?: string
		}]

		// The list of foreign servers to be managed in the database
		servers?: [...{
			// Specifies whether an object (e.g schema) should be present or
			// absent
			// in the database. If set to `present`, the object will be
			// created if
			// it does not exist. If set to `absent`, the extension/schema
			// will be
			// removed if it exists.
			ensure?: "present" | "absent"

			// The name of the Foreign Data Wrapper (FDW)
			fdw!: string

			// Name of the object (extension, schema, FDW, server)
			name!: string

			// Options specifies the configuration options for the server
			// (key is the option name, value is the option value).
			options?: [...{
				// Specifies whether an option should be present or absent in
				// the database. If set to `present`, the option will be
				// created if it does not exist. If set to `absent`, the
				// option will be removed if it exists.
				ensure?: "present" | "absent"

				// Name of the option
				name!: string

				// Value of the option
				value!: string
			}]

			// List of roles for which `USAGE` privileges on the server are
			// granted or revoked.
			usage?: [...{
				// Name of the usage
				name!: string

				// The type of usage
				type?: "grant" | "revoke"
			}]
		}]

		// Maps to the `TABLESPACE` parameter of `CREATE DATABASE`.
		// Maps to the `SET TABLESPACE` command of `ALTER DATABASE`.
		// The name of the tablespace (in PostgreSQL) that will be
		// associated
		// with the new database. This tablespace will be the default
		// tablespace used for objects created in this database.
		tablespace?: string

		// Maps to the `TEMPLATE` parameter of `CREATE DATABASE`. This
		// setting
		// cannot be changed. The name of the template from which to
		// create
		// this database.
		template?: string
	}

	// Most recently observed status of the Database. This data may
	// not be up to
	// date. Populated by the system. Read-only.
	// More info:
	// https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#spec-and-status
	status?: {
		// Applied is true if the database was reconciled correctly
		applied?: bool

		// Extensions is the status of the managed extensions
		extensions?: [...{
			// True of the object has been installed successfully in
			// the database
			applied!: bool

			// Message is the object reconciliation message
			message?: string

			// The name of the object
			name!: string
		}]

		// FDWs is the status of the managed FDWs
		fdws?: [...{
			// True of the object has been installed successfully in
			// the database
			applied!: bool

			// Message is the object reconciliation message
			message?: string

			// The name of the object
			name!: string
		}]

		// Message is the reconciliation output message
		message?: string

		// A sequence number representing the latest
		// desired state that was synchronized
		observedGeneration?: int64 & int

		// Schemas is the status of the managed schemas
		schemas?: [...{
			// True of the object has been installed successfully in
			// the database
			applied!: bool

			// Message is the object reconciliation message
			message?: string

			// The name of the object
			name!: string
		}]

		// Servers is the status of the managed servers
		servers?: [...{
			// True of the object has been installed successfully in
			// the database
			applied!: bool

			// Message is the object reconciliation message
			message?: string

			// The name of the object
			name!: string
		}]
	}

	_embeddedResource: {
		apiVersion!: string
		kind!:       string
		metadata?: {
			...
		}
	}
	apiVersion: "postgresql.cnpg.io/v1"
	kind:       "Database"
	metadata!: {
		name!:      string
		namespace!: string
		labels?: [string]: string
		annotations?: [string]: string
		...
	}
}
