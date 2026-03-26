package v1

import "time"

#Backup: {
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

	// Specification of the desired behavior of the backup.
	// More info:
	// https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#spec-and-status
	spec!: {
		// The cluster to backup
		cluster!: {
			// Name of the referent.
			name!: string
		}

		// The backup method to be used, possible options are
		// `barmanObjectStore`,
		// `volumeSnapshot` or `plugin`. Defaults to: `barmanObjectStore`.
		method?: "barmanObjectStore" | "volumeSnapshot" | "plugin"

		// Whether the default type of backup with volume snapshots is
		// online/hot (`true`, default) or offline/cold (`false`)
		// Overrides the default setting specified in the cluster field
		// '.spec.backup.volumeSnapshot.online'
		online?: bool

		// Configuration parameters to control the online/hot backup with
		// volume snapshots
		// Overrides the default settings specified in the cluster
		// '.backup.volumeSnapshot.onlineConfiguration' stanza
		onlineConfiguration?: {
			// Control whether the I/O workload for the backup initial
			// checkpoint will
			// be limited, according to the `checkpoint_completion_target`
			// setting on
			// the PostgreSQL server. If set to true, an immediate checkpoint
			// will be
			// used, meaning PostgreSQL will complete the checkpoint as soon
			// as
			// possible. `false` by default.
			immediateCheckpoint?: bool

			// If false, the function will return immediately after the backup
			// is completed,
			// without waiting for WAL to be archived.
			// This behavior is only useful with backup software that
			// independently monitors WAL archiving.
			// Otherwise, WAL required to make the backup consistent might be
			// missing and make the backup useless.
			// By default, or when this parameter is true, pg_backup_stop will
			// wait for WAL to be archived when archiving is
			// enabled.
			// On a standby, this means that it will wait only when
			// archive_mode = always.
			// If write activity on the primary is low, it may be useful to
			// run pg_switch_wal on the primary in order to trigger
			// an immediate segment switch.
			waitForArchive?: bool
		}

		// Configuration parameters passed to the plugin managing this
		// backup
		pluginConfiguration?: {
			// Name is the name of the plugin managing this backup
			name!: string

			// Parameters are the configuration parameters passed to the
			// backup
			// plugin for this backup
			parameters?: [string]: string
		}

		// The policy to decide which instance should perform this backup.
		// If empty,
		// it defaults to `cluster.spec.backup.target`.
		// Available options are empty string, `primary` and
		// `prefer-standby`.
		// `primary` to have backups run always on primary instances,
		// `prefer-standby` to have backups run preferably on the most
		// updated
		// standby, if available.
		target?: "primary" | "prefer-standby"
	}

	// Most recently observed status of the backup. This data may not
	// be up to
	// date. Populated by the system. Read-only.
	// More info:
	// https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#spec-and-status
	status?: {
		// The credentials to use to upload data to Azure Blob Storage
		azureCredentials?: {
			// The connection string to be used
			connectionString?: {
				// The key to select
				key!: string

				// Name of the referent.
				name!: string
			}

			// Use the Azure AD based authentication without providing
			// explicitly the keys.
			inheritFromAzureAD?: bool

			// The storage account where to upload data
			storageAccount?: {
				// The key to select
				key!: string

				// Name of the referent.
				name!: string
			}

			// The storage account key to be used in conjunction
			// with the storage account name
			storageKey?: {
				// The key to select
				key!: string

				// Name of the referent.
				name!: string
			}

			// A shared-access-signature to be used in conjunction with
			// the storage account name
			storageSasToken?: {
				// The key to select
				key!: string

				// Name of the referent.
				name!: string
			}

			// Use the default Azure authentication flow, which includes
			// DefaultAzureCredential.
			// This allows authentication using environment variables and
			// managed identities.
			useDefaultAzureCredentials?: bool
		}

		// The ID of the Barman backup
		backupId?: string

		// Backup label file content as returned by Postgres in case of
		// online (hot) backups
		backupLabelFile?: string

		// The Name of the Barman backup
		backupName?: string

		// The starting xlog
		beginLSN?: string

		// The starting WAL
		beginWal?: string

		// The backup command output in case of error
		commandError?: string

		// Unused. Retained for compatibility with old versions.
		commandOutput?: string

		// The path where to store the backup (i.e.
		// s3://bucket/path/to/folder)
		// this path, with different destination folders, will be used for
		// WALs
		// and for data. This may not be populated in case of errors.
		destinationPath?: string

		// Encryption method required to S3 API
		encryption?: string

		// The ending xlog
		endLSN?: string

		// The ending WAL
		endWal?: string

		// EndpointCA store the CA bundle of the barman endpoint.
		// Useful when using self-signed certificates to avoid
		// errors with certificate issuer and barman-cloud-wal-archive.
		endpointCA?: {
			// The key to select
			key!: string

			// Name of the referent.
			name!: string
		}

		// Endpoint to be used to upload data to the cloud,
		// overriding the automatic endpoint discovery
		endpointURL?: string

		// The detected error
		error?: string

		// The credentials to use to upload data to Google Cloud Storage
		googleCredentials?: {
			// The secret containing the Google Cloud Storage JSON file with
			// the credentials
			applicationCredentials?: {
				// The key to select
				key!: string

				// Name of the referent.
				name!: string
			}

			// If set to true, will presume that it's running inside a GKE
			// environment,
			// default to false.
			gkeEnvironment?: bool
		}

		// Information to identify the instance where the backup has been
		// taken from
		instanceID?: {
			// The container ID
			ContainerID?: string

			// The pod name
			podName?: string

			// The instance manager session ID. This is a unique identifier
			// generated at instance manager
			// startup and changes on every restart (including container
			// reboots). Used to detect if
			// the instance manager was restarted during long-running
			// operations like backups, which
			// would terminate any running backup process.
			sessionID?: string
		}

		// The PostgreSQL major version that was running when the
		// backup was taken.
		majorVersion?: int

		// The backup method being used
		method?: string

		// Whether the backup was online/hot (`true`) or offline/cold
		// (`false`)
		online?: bool

		// The last backup status
		phase?: string

		// A map containing the plugin metadata
		pluginMetadata?: [string]: string

		// The credentials to use to upload data to S3
		s3Credentials?: {
			// The reference to the access key id
			accessKeyId?: {
				// The key to select
				key!: string

				// Name of the referent.
				name!: string
			}

			// Use the role based authentication without providing explicitly
			// the keys.
			inheritFromIAMRole?: bool

			// The reference to the secret containing the region name
			region?: {
				// The key to select
				key!: string

				// Name of the referent.
				name!: string
			}

			// The reference to the secret access key
			secretAccessKey?: {
				// The key to select
				key!: string

				// Name of the referent.
				name!: string
			}

			// The references to the session key
			sessionToken?: {
				// The key to select
				key!: string

				// Name of the referent.
				name!: string
			}
		}

		// The server name on S3, the cluster name is used if this
		// parameter is omitted
		serverName?: string

		// Status of the volumeSnapshot backup
		snapshotBackupStatus?: {
			// The elements list, populated with the gathered volume snapshots
			elements?: [...{
				// Name is the snapshot resource name
				name!: string

				// TablespaceName is the name of the snapshotted tablespace. Only
				// set
				// when type is PG_TABLESPACE
				tablespaceName?: string

				// Type is tho role of the snapshot in the cluster, such as
				// PG_DATA, PG_WAL and PG_TABLESPACE
				type!: string
			}]
		}

		// When the backup was started
		startedAt?: time.Time

		// When the backup was terminated
		stoppedAt?: time.Time

		// Tablespace map file content as returned by Postgres in case of
		// online (hot) backups
		tablespaceMapFile?: string
	}

	_embeddedResource: {
		apiVersion!: string
		kind!:       string
		metadata?: {
			...
		}
	}
	apiVersion: "postgresql.cnpg.io/v1"
	kind:       "Backup"
	metadata!: {
		name!:      string
		namespace!: string
		labels?: [string]: string
		annotations?: [string]: string
		...
	}
}
