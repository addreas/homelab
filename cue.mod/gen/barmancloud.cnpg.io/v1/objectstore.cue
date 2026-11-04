package v1

import (
	"strings"
	"time"
)

#ObjectStore: {
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
	metadata!: {}

	// Specification of the desired behavior of the ObjectStore.
	// More info:
	// https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#spec-and-status
	spec!: {
		// The configuration for the barman-cloud tool suite
		configuration!: {
			// The credentials to use to upload data to Azure Blob Storage
			azureCredentials?: {
				// The connection string to be used
				connectionString?: {
					// The key to select
					key!: string

					// Name of the referent.
					name!: string
				}

				// Use the Azure AD based authentication without providing explicitly the keys.
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

				// Use the default Azure authentication flow, which includes DefaultAzureCredential.
				// This allows authentication using environment variables and managed identities.
				useDefaultAzureCredentials?: bool
			}

			// The configuration to be used to backup the data files
			// When not defined, base backups files will be stored uncompressed and may
			// be unencrypted in the object store, according to the bucket default
			// policy.
			data?: {
				// AdditionalCommandArgs represents additional arguments that can be appended
				// to the 'barman-cloud-backup' command-line invocation. These arguments
				// provide flexibility to customize the backup process further according to
				// specific requirements or configurations.
				//
				// Example:
				// In a scenario where specialized backup options are required, such as setting
				// a specific timeout or defining custom behavior, users can use this field
				// to specify additional command arguments.
				//
				// Note:
				// It's essential to ensure that the provided arguments are valid and supported
				// by the 'barman-cloud-backup' command, to avoid potential errors or unintended
				// behavior during execution.
				additionalCommandArgs?: [...string]

				// Compress a backup file (a tar file per tablespace) while streaming it
				// to the object store. Available options are empty string (no
				// compression, default), `gzip`, `bzip2`, `lz4`, and `snappy`.
				compression?: "bzip2" | "gzip" | "lz4" | "snappy"

				// Whenever to force the encryption of files (if the bucket is
				// not already configured for that).
				// Allowed options are empty string (use the bucket policy, default),
				// `AES256` and `aws:kms`
				encryption?: "AES256" | "aws:kms"

				// Control whether the I/O workload for the backup initial checkpoint will
				// be limited, according to the `checkpoint_completion_target` setting on
				// the PostgreSQL server. If set to true, an immediate checkpoint will be
				// used, meaning PostgreSQL will complete the checkpoint as soon as
				// possible. `false` by default.
				immediateCheckpoint?: bool

				// The number of parallel jobs to be used to upload the backup, defaults
				// to 2
				jobs?: int32 & int & >=1

				// Additional arguments that can be appended to the 'barman-cloud-restore'
				// command-line invocation. These arguments provide flexibility to customize
				// the data restore process further, according to specific requirements or
				// configurations.
				//
				// Example:
				// In a scenario where specialized restore options are required, such as setting
				// a specific read timeout or defining custom behavior, users can use this field
				// to specify additional command arguments.
				//
				// Note:
				// It's essential to ensure that the provided arguments are valid and supported
				// by the 'barman-cloud-restore' command, to avoid potential errors or unintended
				// behavior during execution.
				restoreAdditionalCommandArgs?: [...string]
			}

			// The path where to store the backup (i.e. s3://bucket/path/to/folder)
			// this path, with different destination folders, will be used for WALs
			// and for data
			destinationPath!: strings.MinRunes(
						1)

			// EndpointCA store the CA bundle of the barman endpoint.
			// Useful when using self-signed certificates to avoid
			// errors with certificate issuer and barman-cloud-wal-archive
			endpointCA?: {
				// The key to select
				key!: string

				// Name of the referent.
				name!: string
			}

			// Endpoint to be used to upload data to the cloud,
			// overriding the automatic endpoint discovery
			endpointURL?: string

			// The credentials to use to upload data to Google Cloud Storage
			googleCredentials?: {
				// The secret containing the Google Cloud Storage JSON file with the credentials
				applicationCredentials?: {
					// The key to select
					key!: string

					// Name of the referent.
					name!: string
				}

				// If set to true, will presume that it's running inside a GKE environment,
				// default to false.
				gkeEnvironment?: bool
			}

			// HistoryTags is a list of key value pairs that will be passed to the
			// Barman --history-tags option.
			historyTags?: [string]: string

			// The credentials to use to upload data to S3
			s3Credentials?: {
				// The reference to the access key id
				accessKeyId?: {
					// The key to select
					key!: string

					// Name of the referent.
					name!: string
				}

				// Use the role based authentication without providing explicitly the keys.
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

			// Tags is a list of key value pairs that will be passed to the
			// Barman --tags option.
			tags?: [string]: string

			// The configuration for the backup of the WAL stream.
			// When not defined, WAL files will be stored uncompressed and may be
			// unencrypted in the object store, according to the bucket default policy.
			wal?: {
				// Additional arguments that can be appended to the 'barman-cloud-wal-archive'
				// command-line invocation. These arguments provide flexibility to customize
				// the WAL archive process further, according to specific requirements or configurations.
				//
				// Example:
				// In a scenario where specialized backup options are required, such as setting
				// a specific timeout or defining custom behavior, users can use this field
				// to specify additional command arguments.
				//
				// Note:
				// It's essential to ensure that the provided arguments are valid and supported
				// by the 'barman-cloud-wal-archive' command, to avoid potential errors or unintended
				// behavior during execution.
				archiveAdditionalCommandArgs?: [...string]

				// Compress a WAL file before sending it to the object store. Available
				// options are empty string (no compression, default), `gzip`, `bzip2`,
				// `lz4`, `snappy`, `xz`, and `zstd`.
				compression?: "bzip2" | "gzip" | "lz4" | "snappy" | "xz" | "zstd"

				// Whenever to force the encryption of files (if the bucket is
				// not already configured for that).
				// Allowed options are empty string (use the bucket policy, default),
				// `AES256` and `aws:kms`
				encryption?: "AES256" | "aws:kms"

				// Number of WAL files to be either archived in parallel (when the
				// PostgreSQL instance is archiving to a backup object store) or
				// restored in parallel (when a PostgreSQL standby is fetching WAL
				// files from a recovery object store). If not specified, WAL files
				// will be processed one at a time. It accepts a positive integer as a
				// value - with 1 being the minimum accepted value.
				maxParallel?: int & >=1

				// Additional arguments that can be appended to the 'barman-cloud-wal-restore'
				// command-line invocation. These arguments provide flexibility to customize
				// the WAL restore process further, according to specific requirements or configurations.
				//
				// Example:
				// In a scenario where specialized backup options are required, such as setting
				// a specific timeout or defining custom behavior, users can use this field
				// to specify additional command arguments.
				//
				// Note:
				// It's essential to ensure that the provided arguments are valid and supported
				// by the 'barman-cloud-wal-restore' command, to avoid potential errors or unintended
				// behavior during execution.
				restoreAdditionalCommandArgs?: [...string]
			}
		}

		// The configuration for the sidecar that runs in the instance pods
		instanceSidecarConfiguration?: {
			// AdditionalContainerArgs is an optional list of command-line arguments
			// to be passed to the sidecar container when it starts.
			// The provided arguments are appended to the container’s default arguments.
			additionalContainerArgs?: [...string]

			// The environment to be explicitly passed to the sidecar
			env?: [...{
				// Name of the environment variable.
				// May consist of any printable ASCII characters except '='.
				name!: string

				// Variable references $(VAR_NAME) are expanded
				// using the previously defined environment variables in the container and
				// any service environment variables. If a variable cannot be resolved,
				// the reference in the input string will be unchanged. Double $$ are reduced
				// to a single $, which allows for escaping the $(VAR_NAME) syntax: i.e.
				// "$$(VAR_NAME)" will produce the string literal "$(VAR_NAME)".
				// Escaped references will never be expanded, regardless of whether the variable
				// exists or not.
				// Defaults to "".
				value?: string

				// Source for the environment variable's value. Cannot be used if value is not empty.
				valueFrom?: {
					// Selects a key of a ConfigMap.
					configMapKeyRef?: {
						// The key to select from the ConfigMap's Data field.
						// Keys in the BinaryData field are not currently propagated to container env vars.
						key!: string

						// Name of the referent.
						// This field is effectively required, but due to backwards compatibility is
						// allowed to be empty. Instances of this type with an empty value here are
						// almost certainly wrong.
						// More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names
						name?: string

						// Specify whether the ConfigMap or its key must be defined
						optional?: bool
					}

					// Selects a field of the pod: supports metadata.name, metadata.namespace,
					// `metadata.labels['<KEY>']`, `metadata.annotations['<KEY>']`,
					// spec.nodeName, spec.serviceAccountName, status.hostIP, status.podIP, status.podIPs.
					fieldRef?: {
						// Version of the schema the FieldPath is written in terms of, defaults to "v1".
						apiVersion?: string

						// Path of the field to select in the specified API version.
						fieldPath!: string
					}

					// FileKeyRef selects a key of the env file.
					// Requires the EnvFiles feature gate to be enabled.
					fileKeyRef?: {
						// The key within the env file. An invalid key will prevent the pod from starting.
						// The keys defined within a source may consist of any printable ASCII characters except '='.
						// During Alpha stage of the EnvFiles feature gate, the key size is limited to 128 characters.
						key!: string

						// Specify whether the file or its key must be defined. If the file or key
						// does not exist, then the env var is not published.
						// If optional is set to true and the specified key does not exist,
						// the environment variable will not be set in the Pod's containers.
						//
						// If optional is set to false and the specified key does not exist,
						// an error will be returned during Pod creation.
						optional?: bool

						// The path within the volume from which to select the file.
						// Must be relative and may not contain the '..' path or start with '..'.
						path!: string

						// The name of the volume mount containing the env file.
						volumeName!: string
					}

					// Selects a resource of the container: only resources limits and requests
					// (limits.cpu, limits.memory, limits.ephemeral-storage, requests.cpu,
					// requests.memory and requests.ephemeral-storage) are currently supported.
					resourceFieldRef?: {
						// Container name: required for volumes, optional for env vars
						containerName?: string

						// Specifies the output format of the exposed resources, defaults to "1"
						divisor?: matchN(>=1, [int, string]) & (int | =~"^(\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))(([KMGTPE]i)|[numkMGTPE]|([eE](\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))))?$")

						// Required: resource to select
						resource!: string
					}

					// Selects a key of a secret in the pod's namespace
					secretKeyRef?: {
						// The key of the secret to select from. Must be a valid secret key.
						key!: string

						// Name of the referent.
						// This field is effectively required, but due to backwards compatibility is
						// allowed to be empty. Instances of this type with an empty value here are
						// almost certainly wrong.
						// More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names
						name?: string

						// Specify whether the Secret or its key must be defined
						optional?: bool
					}
				}
			}]

			// The log level for PostgreSQL instances. Valid values are: `error`, `warning`,
			// `info` (default), `debug`, `trace`
			logLevel?: "error" | "warning" | "info" | "debug" | "trace"

			// Resources define cpu/memory requests and limits for the sidecar that runs in the instance pods.
			resources?: {
				// Claims lists the names of resources, defined in spec.resourceClaims,
				// that are used by this container.
				//
				// This field depends on the
				// DynamicResourceAllocation feature gate.
				//
				// This field is immutable. It can only be set for containers.
				claims?: [...{
					// Name must match the name of one entry in pod.spec.resourceClaims of
					// the Pod where this field is used. It makes that resource available
					// inside a container.
					name!: string

					// Request is the name chosen for a request in the referenced claim.
					// If empty, everything from the claim is made available, otherwise
					// only the result of this request.
					request?: string
				}]

				// Limits describes the maximum amount of compute resources allowed.
				// More info: https://kubernetes.io/docs/concepts/configuration/manage-resources-containers/
				limits?: [string]: matchN(>=1, [int, string]) & (int | =~"^(\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))(([KMGTPE]i)|[numkMGTPE]|([eE](\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))))?$")

				// Requests describes the minimum amount of compute resources required.
				// If Requests is omitted for a container, it defaults to Limits if that is explicitly specified,
				// otherwise to an implementation-defined value. Requests cannot exceed Limits.
				// More info: https://kubernetes.io/docs/concepts/configuration/manage-resources-containers/
				requests?: [string]: matchN(>=1, [int, string]) & (int | =~"^(\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))(([KMGTPE]i)|[numkMGTPE]|([eE](\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))))?$")
			}

			// The retentionCheckInterval defines the frequency at which the
			// system checks and enforces retention policies.
			retentionPolicyIntervalSeconds?: int
		}

		// RetentionPolicy is the retention policy to be used for backups
		// and WALs (i.e. '60d'). The retention policy is expressed in the form
		// of `XXu` where `XX` is a positive integer and `u` is in `[dwm]` -
		// days, weeks, months.
		retentionPolicy?: =~"^[1-9][0-9]*[dwm]$"
	}

	// Most recently observed status of the ObjectStore. This data may not be up to
	// date. Populated by the system. Read-only.
	// More info:
	// https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#spec-and-status
	status?: {
		// ServerRecoveryWindow maps each server to its recovery window
		serverRecoveryWindow?: [string]: {
			// The first recoverability point in a PostgreSQL server refers to
			// the earliest point in time to which the database can be
			// restored.
			firstRecoverabilityPoint?: time.Time

			// The last failed backup time
			lastFailedBackupTime?: time.Time

			// The last successful backup time
			lastSuccessfulBackupTime?: time.Time
		}
	}

	_embeddedResource: {
		apiVersion!: string
		kind!:       string
		metadata?: {
			...
		}
	}
	apiVersion: "barmancloud.cnpg.io/v1"
	kind:       "ObjectStore"
	metadata!: {
		name!:      string
		namespace!: string
		labels?: [string]: string
		annotations?: [string]: string
		...
	}
}
