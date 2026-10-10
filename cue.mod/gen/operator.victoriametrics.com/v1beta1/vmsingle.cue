package v1beta1

import (
	"strings"
	"time"
)

#VMSingle: {
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

	// VMSingleSpec defines the desired state of VMSingle
	spec?: {
		// AdditionalScrapeConfigs As scrape configs are appended, the user is responsible to make sure it
		// is valid. Note that using this feature may expose the possibility to
		// break upgrades of VMAgent or VMSingle. It is advised to review VMAgent or VMSingle release
		// notes to ensure that no incompatible scrape configs are going to break
		// VMAgent or VMSingle after the upgrade.
		additionalScrapeConfigs?: {
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

		// Affinity If specified, the pod's scheduling constraints.
		affinity?: {
			...
		}

		// APIServerConfig allows specifying a host and auth methods to access apiserver.
		// If left empty, VMSingle is assumed to run inside of the cluster
		// and will discover API servers automatically and use the pod's CA certificate
		// and bearer token file at /var/run/secrets/kubernetes.io/serviceaccount/.
		apiServerConfig?: {
			// Authorization configures generic authorization params
			authorization?: {
				// Reference to the secret with value for authorization
				credentials?: {
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

				// File with value for authorization
				credentialsFile?: string

				// Type of authorization, default to bearer
				type?: string
			}

			// BasicAuth allow an endpoint to authenticate over basic authentication
			basicAuth?: {
				// Password defines reference for secret with password value
				// The secret needs to be in the same namespace as scrape object
				password?: {
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

				// PasswordFile defines path to password file at disk
				// must be pre-mounted
				password_file?: string

				// Username defines reference for secret with username value
				// The secret needs to be in the same namespace as scrape object
				username?: {
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

			// Bearer token for accessing apiserver.
			bearerToken?: string

			// File to read bearer token for accessing apiserver.
			bearerTokenFile?: string

			// Host of apiserver.
			// A valid string consisting of a hostname or IP followed by an optional port number
			host!: string

			// TLSConfig Config to use for accessing apiserver.
			tlsConfig?: {
				// Struct containing the CA cert to use for the targets.
				ca?: {
					// ConfigMap containing data to use for the targets.
					configMap?: {
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

					// Secret containing data to use for the targets.
					secret?: {
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

				// Path to the CA cert in the container to use for the targets.
				caFile?: string

				// Struct containing the client cert file for the targets.
				cert?: {
					// ConfigMap containing data to use for the targets.
					configMap?: {
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

					// Secret containing data to use for the targets.
					secret?: {
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

				// Path to the client cert file in the container for the targets.
				certFile?: string

				// Disable target certificate validation.
				insecureSkipVerify?: bool

				// Path to the client key file in the container for the targets.
				keyFile?: string

				// Secret containing the client key file for the targets.
				keySecret?: {
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

				// Used to verify the hostname for the targets.
				serverName?: string
			}
		}

		// ArbitraryFSAccessThroughSMs configures whether configuration
		// based on EndpointAuth can access arbitrary files on the file system
		// of the VMAgent or VMSingle container e.g. bearer token files, basic auth, tls certs
		arbitraryFSAccessThroughSMs?: deny?: bool

		// ComponentVersion defines default images tag for all components.
		// it can be overwritten with component specific image.tag value.
		componentVersion?: string

		// ConfigMaps is a list of ConfigMaps in the same namespace as the Application
		// object, which shall be mounted into the Application container
		// at /etc/vm/configs/CONFIGMAP_NAME folder
		configMaps?: [...string]

		// ConfigReloadAuthKeySecret defines optional secret reference authKey for /-/reload API requests.
		// Given secret reference will be added to the application and vm-config-reloader as volume
		configReloadAuthKeySecret?: {
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

		// ConfigReloaderExtraArgs that will be passed to VMAuths config-reloader container
		// for example resync-interval: "30s"
		configReloaderExtraArgs?: [string]: string

		// ConfigReloaderImage defines image:tag for config-reloader container
		configReloaderImage?: string

		// ConfigReloaderImageTag defines image:tag for config-reloader container
		configReloaderImageTag?: string

		// ConfigReloaderResources config-reloader container resource request and
		// limits,
		// https://kubernetes.io/docs/concepts/configuration/manage-resources-containers/
		// if not defined default resources from operator config will be used
		configReloaderResources?: {
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

		// Containers property allows to inject additions sidecars or to patch existing containers.
		// It can be useful for proxies, backup, etc.
		containers?: [...{
			name!: _
			...
		}]

		// DisableAutomountServiceAccountToken whether to disable serviceAccount auto mount by Kubernetes
		// Operator will conditionally create volumes and volumeMounts for containers if
		// it requires k8s API access.
		// For example, vmagent and vm-config-reloader requires k8s API access.
		// Operator creates volumes with name: "kube-api-access", which can be used as
		// volumeMount for extraContainers if needed.
		// And also adds VolumeMounts at /var/run/secrets/kubernetes.io/serviceaccount.
		disableAutomountServiceAccountToken?: bool

		// DisableSelfServiceScrape controls creation of VMServiceScrape by operator
		// for the application.
		// Has priority over `VM_DISABLESELFSERVICESCRAPECREATION` operator env variable
		disableSelfServiceScrape?: bool

		// Specifies the DNS parameters of a pod.
		// Parameters specified here will be merged to the generated DNS
		// configuration based on DNSPolicy.
		dnsConfig?: {
			...
		}

		// DNSPolicy sets DNS policy for the pod
		dnsPolicy?: string

		// Downsampling defines downsampling rules for VMSingle.
		// Requires enterprise license. See
		// https://docs.victoriametrics.com/victoriametrics/single-server-victoriametrics/#downsampling
		downsampling?: {
			// DedupInterval sets the deduplication interval used with downsampling.
			// It corresponds to -dedup.minScrapeInterval flag.
			// Must be a multiple of all configured downsampling intervals.
			dedupInterval?: string

			// Rules defines downsampling rules.
			// Each rule matches time series by an optional filter and applies downsampling
			// after a given offset.
			rules?: [...{
				// Filter is an optional MetricsQL label filter for matching time series.
				// If not set, the rule is applied to all time series.
				// Example: '{env="prod"}'
				filter?: string

				// Periods defines the downsampling time horizons applied to matching series.
				periods!: [...{
					// Interval is the target downsampling resolution; only the last sample per interval is kept.
					// Example: "10m"
					interval!: string

					// Offset is the minimum age of data before downsampling is applied.
					// Example: "30d"
					offset!: string
				}]
			}]
		}

		// EnableKubernetesAPISelectors instructs vmagent or vmsingle to use CRD scrape
		// objects spec.selectors for
		// Kubernetes API list and watch requests.
		// https://kubernetes.io/docs/concepts/overview/working-with-objects/labels/#list-and-watch-filtering
		// It could be useful to reduce Kubernetes API server resource usage for serving
		// less than 100 CRD scrape objects in total.
		enableKubernetesAPISelectors?: bool

		// EnableServiceLinks indicates whether information about services should be injected into pod's
		// environment variables, matching the syntax of Docker links.
		// Optional: Defaults to true.
		enableServiceLinks?: bool

		// EnforcedNamespaceLabel enforces adding a namespace label of origin for each alert
		// and metric that is user created. The label value will always be the namespace
		// of the object that is
		// being created.
		enforcedNamespaceLabel?: string

		// ExternalLabelName Name of external label used to denote scraping agent instance
		// name. Defaults to the value of `prometheus`. External label will
		// _not_ be added when value is set to empty string (`""`).
		externalLabelName?: string

		// ExternalLabels The labels to add to any time series scraped by vmagent or vmsingle.
		// it doesn't affect metrics ingested directly by push API's
		externalLabels?: [string]: string

		// ExtraArgs that will be passed to the application container
		// for example remoteWrite.tmpDataPath: /tmp
		extraArgs?: [string]: string

		// ExtraEnvs that will be passed to the application container
		extraEnvs?: [...{
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
			...
		}]

		// ExtraEnvsFrom defines source of env variables for the application container
		// could either be secret or configmap
		extraEnvsFrom?: [...{
			// The ConfigMap to select from
			configMapRef?: {
				// Name of the referent.
				// This field is effectively required, but due to backwards compatibility is
				// allowed to be empty. Instances of this type with an empty value here are
				// almost certainly wrong.
				// More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names
				name?: string

				// Specify whether the ConfigMap must be defined
				optional?: bool
			}

			// Optional text to prepend to the name of each environment variable.
			// May consist of any printable ASCII characters except '='.
			prefix?: string

			// The Secret to select from
			secretRef?: {
				// Name of the referent.
				// This field is effectively required, but due to backwards compatibility is
				// allowed to be empty. Instances of this type with an empty value here are
				// almost certainly wrong.
				// More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names
				name?: string

				// Specify whether the Secret must be defined
				optional?: bool
			}
		}]

		// GlobalScrapeMetricRelabelConfigs is a global metric relabel configuration,
		// which is applied to each scrape job.
		globalScrapeMetricRelabelConfigs?: [...{
			// Action to perform based on regex matching. Default is 'replace'
			action?: string

			// If represents metricsQL match expression (or list of expressions): '{__name__=~"foo_.*"}'
			if?: null | bool | number | string | [...] | {
				...
			}

			// Labels is used together with Match for `action: graphite`
			labels?: [string]: string

			// Match is used together with Labels for `action: graphite`
			match?: string

			// Modulus to take of the hash of the source label values.
			modulus?: int64 & int

			// Regular expression against which the extracted value is matched. Default is '(.*)'
			// victoriaMetrics supports multiline regex joined with |
			// https://docs.victoriametrics.com/victoriametrics/vmagent/#relabeling-enhancements
			regex?: null | bool | number | string | [...] | {
				...
			}

			// Replacement value against which a regex replace is performed if the
			// regular expression matches. Regex capture groups are available. Default is '$1'
			replacement?: string

			// Separator placed between concatenated source label values. default is ';'.
			separator?: string

			// UnderScoreSourceLabels - additional form of source labels source_labels
			// for compatibility with original relabel config.
			// if set both sourceLabels and source_labels, sourceLabels has priority.
			// for details https://github.com/VictoriaMetrics/operator/issues/131
			source_labels?: [...string]

			// The source labels select values from existing labels. Their content is concatenated
			// using the configured separator and matched against the configured regular expression
			// for the replace, keep, and drop actions.
			sourceLabels?: [...string]

			// UnderScoreTargetLabel - additional form of target label - target_label
			// for compatibility with original relabel config.
			// if set both targetLabel and target_label, targetLabel has priority.
			// for details https://github.com/VictoriaMetrics/operator/issues/131
			target_label?: string

			// Label to which the resulting value is written in a replace action.
			// It is mandatory for replace actions. Regex capture groups are available.
			targetLabel?: string
		}]

		// GlobalScrapeRelabelConfigs is a global relabel configuration, which is
		// applied to each samples of each scrape job during service discovery.
		globalScrapeRelabelConfigs?: [...{
			// Action to perform based on regex matching. Default is 'replace'
			action?: string

			// If represents metricsQL match expression (or list of expressions): '{__name__=~"foo_.*"}'
			if?: null | bool | number | string | [...] | {
				...
			}

			// Labels is used together with Match for `action: graphite`
			labels?: [string]: string

			// Match is used together with Labels for `action: graphite`
			match?: string

			// Modulus to take of the hash of the source label values.
			modulus?: int64 & int

			// Regular expression against which the extracted value is matched. Default is '(.*)'
			// victoriaMetrics supports multiline regex joined with |
			// https://docs.victoriametrics.com/victoriametrics/vmagent/#relabeling-enhancements
			regex?: null | bool | number | string | [...] | {
				...
			}

			// Replacement value against which a regex replace is performed if the
			// regular expression matches. Regex capture groups are available. Default is '$1'
			replacement?: string

			// Separator placed between concatenated source label values. default is ';'.
			separator?: string

			// UnderScoreSourceLabels - additional form of source labels source_labels
			// for compatibility with original relabel config.
			// if set both sourceLabels and source_labels, sourceLabels has priority.
			// for details https://github.com/VictoriaMetrics/operator/issues/131
			source_labels?: [...string]

			// The source labels select values from existing labels. Their content is concatenated
			// using the configured separator and matched against the configured regular expression
			// for the replace, keep, and drop actions.
			sourceLabels?: [...string]

			// UnderScoreTargetLabel - additional form of target label - target_label
			// for compatibility with original relabel config.
			// if set both targetLabel and target_label, targetLabel has priority.
			// for details https://github.com/VictoriaMetrics/operator/issues/131
			target_label?: string

			// Label to which the resulting value is written in a replace action.
			// It is mandatory for replace actions. Regex capture groups are available.
			targetLabel?: string
		}]

		// HostAliasesUnderScore provides mapping for ip and hostname,
		// that would be propagated to pod,
		// cannot be used with HostNetwork.
		// Has Priority over hostAliases field
		host_aliases?: [...{
			// Hostnames for the above IP address.
			hostnames?: [...string]

			// IP address of the host file entry.
			ip!: string
		}]

		// HostAliases provides mapping for ip and hostname,
		// that would be propagated to pod,
		// cannot be used with HostNetwork.
		hostAliases?: [...{
			// Hostnames for the above IP address.
			hostnames?: [...string]

			// IP address of the host file entry.
			ip!: string
		}]

		// HostNetwork controls whether the pod may use the node network namespace
		hostNetwork?: bool

		// IgnoreNamespaceSelectors if set to true will ignore NamespaceSelector settings from
		// scrape objects, and they will only discover endpoints
		// within their current namespace. Defaults to false.
		ignoreNamespaceSelectors?: bool

		// Image - docker image settings
		// if no specified operator uses default version from operator config
		image?: {
			// PullPolicy describes how to pull docker image
			pullPolicy?: string

			// Repository contains name of docker image + it's repository if needed
			repository?: string

			// Tag contains desired docker image version.
			// It may be a regular tag (e.g. "v1.96.0") or a digest
			// (e.g. "sha256:<hex>"); a digest is joined to the repository with "@"
			// instead of ":", allowing images to be pinned by digest.
			tag?: string
		}

		// ImagePullSecrets An optional list of references to secrets in the same namespace
		// to use for pulling images from registries
		// see https://kubernetes.io/docs/concepts/containers/images/#specifying-imagepullsecrets-on-a-pod
		imagePullSecrets?: [...{
			// Name of the referent.
			// This field is effectively required, but due to backwards compatibility is
			// allowed to be empty. Instances of this type with an empty value here are
			// almost certainly wrong.
			// More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names
			name?: string
		}]

		// IngestOnlyMode switches vmagent or vmsingle into unmanaged mode
		// it disables any config generation for scraping
		// Currently it prevents vmagent or vmsingle from managing tls and auth options for remote write
		ingestOnlyMode?: bool

		// InitContainers allows adding initContainers to the pod definition.
		// Any errors during the execution of an initContainer will lead to a restart of the Pod.
		// More info: https://kubernetes.io/docs/concepts/workloads/pods/init-containers/
		initContainers?: [...{
			name!: _
			...
		}]

		// InlineRelabelConfig - defines GlobalRelabelConfig for vmagent, can be defined directly at CRD.
		inlineRelabelConfig?: [...{
			// Action to perform based on regex matching. Default is 'replace'
			action?: string

			// If represents metricsQL match expression (or list of expressions): '{__name__=~"foo_.*"}'
			if?: null | bool | number | string | [...] | {
				...
			}

			// Labels is used together with Match for `action: graphite`
			labels?: [string]: string

			// Match is used together with Labels for `action: graphite`
			match?: string

			// Modulus to take of the hash of the source label values.
			modulus?: int64 & int

			// Regular expression against which the extracted value is matched. Default is '(.*)'
			// victoriaMetrics supports multiline regex joined with |
			// https://docs.victoriametrics.com/victoriametrics/vmagent/#relabeling-enhancements
			regex?: null | bool | number | string | [...] | {
				...
			}

			// Replacement value against which a regex replace is performed if the
			// regular expression matches. Regex capture groups are available. Default is '$1'
			replacement?: string

			// Separator placed between concatenated source label values. default is ';'.
			separator?: string

			// UnderScoreSourceLabels - additional form of source labels source_labels
			// for compatibility with original relabel config.
			// if set both sourceLabels and source_labels, sourceLabels has priority.
			// for details https://github.com/VictoriaMetrics/operator/issues/131
			source_labels?: [...string]

			// The source labels select values from existing labels. Their content is concatenated
			// using the configured separator and matched against the configured regular expression
			// for the replace, keep, and drop actions.
			sourceLabels?: [...string]

			// UnderScoreTargetLabel - additional form of target label - target_label
			// for compatibility with original relabel config.
			// if set both targetLabel and target_label, targetLabel has priority.
			// for details https://github.com/VictoriaMetrics/operator/issues/131
			target_label?: string

			// Label to which the resulting value is written in a replace action.
			// It is mandatory for replace actions. Regex capture groups are available.
			targetLabel?: string
		}]

		// InlineScrapeConfig As scrape configs are appended, the user is responsible to make sure it
		// is valid. Note that using this feature may expose the possibility to
		// break upgrades of VMAgent or VMSingle. It is advised to review VMAgent or VMSingle release
		// notes to ensure that no incompatible scrape configs are going to break
		// VMAgent or VMSingle after the upgrade.
		// it should be defined as single yaml file.
		// inlineScrapeConfig: |
		// - job_name: "prometheus"
		// static_configs:
		// - targets: ["localhost:9090"]
		inlineScrapeConfig?: string

		// InsertPorts - additional listen ports for data ingestion.
		insertPorts?: {
			// GraphitePort listen port
			graphitePort?: string

			// InfluxPort listen port
			influxPort?: string

			// OpenTSDBHTTPPort for http connections.
			openTSDBHTTPPort?: string

			// OpenTSDBPort for tcp and udp listen
			openTSDBPort?: string
		}

		// License allows to configure license key to be used for enterprise features.
		// Using license key is supported starting from VictoriaMetrics v1.94.0.
		// See [here](https://docs.victoriametrics.com/victoriametrics/enterprise/)
		license?: {
			// Enforce offline verification of the license key.
			forceOffline?: bool

			// Enterprise license key. This flag is available only in [VictoriaMetrics
			// enterprise](https://docs.victoriametrics.com/victoriametrics/enterprise/).
			// To request a trial license, [go to](https://victoriametrics.com/products/enterprise/trial)
			key?: string

			// KeyRef is reference to secret with license key for enterprise features.
			keyRef?: {
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

			// Interval to be used for checking for license key changes. Note that this is
			// only applicable when using KeyRef.
			reloadInterval?: string
		}

		// LivenessProbe that will be added to CR pod
		livenessProbe?: {
			...
		}

		// LogFormat for VMSingle to be configured with.
		logFormat?: "default" | "json"

		// LogLevel for victoria metrics single to be configured with.
		logLevel?: "INFO" | "WARN" | "ERROR" | "FATAL" | "PANIC"

		// ManagedMetadata defines metadata that will be added to the all objects
		// created by operator for the given CustomResource
		managedMetadata?: {
			// Annotations is an unstructured key value map stored with a resource that may be
			// set by external tools to store and retrieve arbitrary metadata. They are not
			// queryable and should be preserved when modifying objects.
			// More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/annotations
			annotations?: [string]: string

			// Labels Map of string keys and values that can be used to organize and categorize
			// (scope and select) objects.
			// More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/labels
			labels?: [string]: string
		}

		// MaxScrapeInterval allows limiting maximum scrape interval for
		// VMServiceScrape, VMPodScrape and other scrapes
		// If interval is higher than defined limit, `maxScrapeInterval` will be used.
		maxScrapeInterval?: string

		// MinReadySeconds defines a minimum number of seconds to wait before starting update next pod
		// if previous in healthy state
		// Has no effect for VLogs and VMSingle
		minReadySeconds?: int32 & int

		// MinScrapeInterval allows limiting minimal scrape interval for
		// VMServiceScrape, VMPodScrape and other scrapes
		// If interval is lower than defined limit, `minScrapeInterval` will be used.
		minScrapeInterval?: string

		// NetworkPolicy defines network access rules for pods created by this CR.
		networkPolicy?: {
			// Egress defines the list of egress rules applied to pods selected by this CR.
			egress?: [...{
				// ports is a list of destination ports for outgoing traffic.
				// Each item in this list is combined using a logical OR. If this field is
				// empty or missing, this rule matches all ports (traffic not restricted by port).
				// If this field is present and contains at least one item, then this rule allows
				// traffic only if the traffic matches at least one port in the list.
				ports?: [...{
					// endPort indicates that the range of ports from port to endPort if set, inclusive,
					// should be allowed by the policy. This field cannot be defined if the port field
					// is not defined or if the port field is defined as a named (string) port.
					// The endPort must be equal or greater than port.
					endPort?: int32 & int

					// port represents the port on the given protocol. This can either be a numerical or named
					// port on a pod. If this field is not provided, this matches all port names and
					// numbers.
					// If present, only traffic on the specified protocol AND port will be matched.
					port?: matchN(>=1, [int, string]) & (int | string)

					// protocol represents the protocol (TCP, UDP, or SCTP) which traffic must match.
					// If not specified, this field defaults to TCP.
					protocol?: string
				}]

				// to is a list of destinations for outgoing traffic of pods selected for this rule.
				// Items in this list are combined using a logical OR operation. If this field is
				// empty or missing, this rule matches all destinations (traffic not restricted by
				// destination). If this field is present and contains at least one item, this rule
				// allows traffic only if the traffic matches at least one item in the to list.
				to?: [...{
					// ipBlock defines policy on a particular IPBlock. If this field is set then
					// neither of the other fields can be.
					ipBlock?: {
						// cidr is a string representing the IPBlock
						// Valid examples are "192.168.1.0/24" or "2001:db8::/64"
						cidr!: string

						// except is a slice of CIDRs that should not be included within an IPBlock
						// Valid examples are "192.168.1.0/24" or "2001:db8::/64"
						// Except values will be rejected if they are outside the cidr range
						except?: [...string]
					}

					// namespaceSelector selects namespaces using cluster-scoped labels. This field follows
					// standard label selector semantics; if present but empty, it selects all namespaces.
					//
					// If podSelector is also set, then the NetworkPolicyPeer as a whole selects
					// the pods matching podSelector in the namespaces selected by namespaceSelector.
					// Otherwise it selects all pods in the namespaces selected by namespaceSelector.
					namespaceSelector?: {
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

					// podSelector is a label selector which selects pods. This field follows standard label
					// selector semantics; if present but empty, it selects all pods.
					//
					// If namespaceSelector is also set, then the NetworkPolicyPeer as a whole selects
					// the pods matching podSelector in the Namespaces selected by NamespaceSelector.
					// Otherwise it selects the pods matching podSelector in the policy's own namespace.
					podSelector?: {
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
				}]
			}]

			// Ingress defines the list of ingress rules applied to pods selected by this CR.
			// Each rule allows traffic which matches both the from and ports sections.
			ingress?: [...{
				// from is a list of sources which should be able to access the pods selected for this rule.
				// Items in this list are combined using a logical OR operation. If this field is
				// empty or missing, this rule matches all sources (traffic not restricted by
				// source). If this field is present and contains at least one item, this rule
				// allows traffic only if the traffic matches at least one item in the from list.
				from?: [...{
					// ipBlock defines policy on a particular IPBlock. If this field is set then
					// neither of the other fields can be.
					ipBlock?: {
						// cidr is a string representing the IPBlock
						// Valid examples are "192.168.1.0/24" or "2001:db8::/64"
						cidr!: string

						// except is a slice of CIDRs that should not be included within an IPBlock
						// Valid examples are "192.168.1.0/24" or "2001:db8::/64"
						// Except values will be rejected if they are outside the cidr range
						except?: [...string]
					}

					// namespaceSelector selects namespaces using cluster-scoped labels. This field follows
					// standard label selector semantics; if present but empty, it selects all namespaces.
					//
					// If podSelector is also set, then the NetworkPolicyPeer as a whole selects
					// the pods matching podSelector in the namespaces selected by namespaceSelector.
					// Otherwise it selects all pods in the namespaces selected by namespaceSelector.
					namespaceSelector?: {
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

					// podSelector is a label selector which selects pods. This field follows standard label
					// selector semantics; if present but empty, it selects all pods.
					//
					// If namespaceSelector is also set, then the NetworkPolicyPeer as a whole selects
					// the pods matching podSelector in the Namespaces selected by NamespaceSelector.
					// Otherwise it selects the pods matching podSelector in the policy's own namespace.
					podSelector?: {
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
				}]

				// ports is a list of ports which should be made accessible on the pods selected for
				// this rule. Each item in this list is combined using a logical OR. If this field is
				// empty or missing, this rule matches all ports (traffic not restricted by port).
				// If this field is present and contains at least one item, then this rule allows
				// traffic only if the traffic matches at least one port in the list.
				ports?: [...{
					// endPort indicates that the range of ports from port to endPort if set, inclusive,
					// should be allowed by the policy. This field cannot be defined if the port field
					// is not defined or if the port field is defined as a named (string) port.
					// The endPort must be equal or greater than port.
					endPort?: int32 & int

					// port represents the port on the given protocol. This can either be a numerical or named
					// port on a pod. If this field is not provided, this matches all port names and
					// numbers.
					// If present, only traffic on the specified protocol AND port will be matched.
					port?: matchN(>=1, [int, string]) & (int | string)

					// protocol represents the protocol (TCP, UDP, or SCTP) which traffic must match.
					// If not specified, this field defaults to TCP.
					protocol?: string
				}]
			}]
		}

		// NodeScrapeNamespaceSelector defines Namespaces to be selected for VMNodeScrape discovery.
		// Works in combination with Selector.
		// NamespaceSelector nil - only objects at VMAgent or VMSingle namespace.
		// Selector nil - only objects at NamespaceSelector namespaces.
		// If both nil - behaviour controlled by selectAllByDefault
		nodeScrapeNamespaceSelector?: {
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

		// NodeScrapeRelabelTemplate defines relabel config, that will be added to each VMNodeScrape.
		// it's useful for adding specific labels to all targets
		nodeScrapeRelabelTemplate?: [...{
			// Action to perform based on regex matching. Default is 'replace'
			action?: string

			// If represents metricsQL match expression (or list of expressions): '{__name__=~"foo_.*"}'
			if?: null | bool | number | string | [...] | {
				...
			}

			// Labels is used together with Match for `action: graphite`
			labels?: [string]: string

			// Match is used together with Labels for `action: graphite`
			match?: string

			// Modulus to take of the hash of the source label values.
			modulus?: int64 & int

			// Regular expression against which the extracted value is matched. Default is '(.*)'
			// victoriaMetrics supports multiline regex joined with |
			// https://docs.victoriametrics.com/victoriametrics/vmagent/#relabeling-enhancements
			regex?: null | bool | number | string | [...] | {
				...
			}

			// Replacement value against which a regex replace is performed if the
			// regular expression matches. Regex capture groups are available. Default is '$1'
			replacement?: string

			// Separator placed between concatenated source label values. default is ';'.
			separator?: string

			// UnderScoreSourceLabels - additional form of source labels source_labels
			// for compatibility with original relabel config.
			// if set both sourceLabels and source_labels, sourceLabels has priority.
			// for details https://github.com/VictoriaMetrics/operator/issues/131
			source_labels?: [...string]

			// The source labels select values from existing labels. Their content is concatenated
			// using the configured separator and matched against the configured regular expression
			// for the replace, keep, and drop actions.
			sourceLabels?: [...string]

			// UnderScoreTargetLabel - additional form of target label - target_label
			// for compatibility with original relabel config.
			// if set both targetLabel and target_label, targetLabel has priority.
			// for details https://github.com/VictoriaMetrics/operator/issues/131
			target_label?: string

			// Label to which the resulting value is written in a replace action.
			// It is mandatory for replace actions. Regex capture groups are available.
			targetLabel?: string
		}]

		// NodeScrapeSelector defines VMNodeScrape to be selected for scraping.
		// Works in combination with NamespaceSelector.
		// NamespaceSelector nil - only objects at VMAgent or VMSingle namespace.
		// Selector nil - only objects at NamespaceSelector namespaces.
		// If both nil - behaviour controlled by selectAllByDefault
		nodeScrapeSelector?: {
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

		// NodeSelector Define which Nodes the Pods are scheduled on.
		nodeSelector?: [string]: string

		// OverrideHonorLabels if set to true overrides all user configured honor_labels.
		// If HonorLabels is set in scrape objects to true, this overrides honor_labels to false.
		overrideHonorLabels?: bool

		// OverrideHonorTimestamps allows to globally enforce honoring timestamps in all scrape configs.
		overrideHonorTimestamps?: bool

		// Paused If set to true all actions on the underlying managed objects are not
		// going to be performed, except for delete actions.
		paused?: bool

		// PodMetadata configures Labels and Annotations which are propagated to the VMSingle pods.
		podMetadata?: {
			// Annotations is an unstructured key value map stored with a resource that may be
			// set by external tools to store and retrieve arbitrary metadata. They are not
			// queryable and should be preserved when modifying objects.
			// More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/annotations
			annotations?: [string]: string

			// Labels Map of string keys and values that can be used to organize and categorize
			// (scope and select) objects. May match selectors of replication controllers
			// and services.
			// More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/labels
			labels?: [string]: string

			// Name must be unique within a namespace. Is required when creating resources, although
			// some resources may allow a client to request the generation of an appropriate name
			// automatically. Name is primarily intended for creation idempotence and configuration
			// definition.
			// Cannot be updated.
			// More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names#names
			name?: string
		}

		// PodScrapeNamespaceSelector defines Namespaces to be selected for VMPodScrape discovery.
		// Works in combination with Selector.
		// NamespaceSelector nil - only objects at VMAgent or VMSingle namespace.
		// Selector nil - only objects at NamespaceSelector namespaces.
		// If both nil - behaviour controlled by selectAllByDefault
		podScrapeNamespaceSelector?: {
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

		// PodScrapeRelabelTemplate defines relabel config, that will be added to each VMPodScrape.
		// it's useful for adding specific labels to all targets
		podScrapeRelabelTemplate?: [...{
			// Action to perform based on regex matching. Default is 'replace'
			action?: string

			// If represents metricsQL match expression (or list of expressions): '{__name__=~"foo_.*"}'
			if?: null | bool | number | string | [...] | {
				...
			}

			// Labels is used together with Match for `action: graphite`
			labels?: [string]: string

			// Match is used together with Labels for `action: graphite`
			match?: string

			// Modulus to take of the hash of the source label values.
			modulus?: int64 & int

			// Regular expression against which the extracted value is matched. Default is '(.*)'
			// victoriaMetrics supports multiline regex joined with |
			// https://docs.victoriametrics.com/victoriametrics/vmagent/#relabeling-enhancements
			regex?: null | bool | number | string | [...] | {
				...
			}

			// Replacement value against which a regex replace is performed if the
			// regular expression matches. Regex capture groups are available. Default is '$1'
			replacement?: string

			// Separator placed between concatenated source label values. default is ';'.
			separator?: string

			// UnderScoreSourceLabels - additional form of source labels source_labels
			// for compatibility with original relabel config.
			// if set both sourceLabels and source_labels, sourceLabels has priority.
			// for details https://github.com/VictoriaMetrics/operator/issues/131
			source_labels?: [...string]

			// The source labels select values from existing labels. Their content is concatenated
			// using the configured separator and matched against the configured regular expression
			// for the replace, keep, and drop actions.
			sourceLabels?: [...string]

			// UnderScoreTargetLabel - additional form of target label - target_label
			// for compatibility with original relabel config.
			// if set both targetLabel and target_label, targetLabel has priority.
			// for details https://github.com/VictoriaMetrics/operator/issues/131
			target_label?: string

			// Label to which the resulting value is written in a replace action.
			// It is mandatory for replace actions. Regex capture groups are available.
			targetLabel?: string
		}]

		// PodScrapeSelector defines PodScrapes to be selected for target discovery.
		// Works in combination with NamespaceSelector.
		// NamespaceSelector nil - only objects at VMAgent or VMSingle namespace.
		// Selector nil - only objects at NamespaceSelector namespaces.
		// If both nil - behaviour controlled by selectAllByDefault
		podScrapeSelector?: {
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

		// Port listen address
		port?: string

		// PreStopSleepSeconds defines the number of seconds to sleep in the preStop lifecycle hook.
		// It gives time for load balancers to remove the pod from rotation before the pod is terminated.
		// Defaults to 15 for applicable components. Set to 0 to disable.
		preStopSleepSeconds?: int32 & int

		// PriorityClassName class assigned to the Pods
		priorityClassName?: string

		// ProbeNamespaceSelector defines Namespaces to be selected for VMProbe discovery.
		// Works in combination with Selector.
		// NamespaceSelector nil - only objects at VMAgent or VMSingle namespace.
		// Selector nil - only objects at NamespaceSelector namespaces.
		// If both nil - behaviour controlled by selectAllByDefault
		probeNamespaceSelector?: {
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

		// ProbeScrapeRelabelTemplate defines relabel config, that will be added to each VMProbeScrape.
		// it's useful for adding specific labels to all targets
		probeScrapeRelabelTemplate?: [...{
			// Action to perform based on regex matching. Default is 'replace'
			action?: string

			// If represents metricsQL match expression (or list of expressions): '{__name__=~"foo_.*"}'
			if?: null | bool | number | string | [...] | {
				...
			}

			// Labels is used together with Match for `action: graphite`
			labels?: [string]: string

			// Match is used together with Labels for `action: graphite`
			match?: string

			// Modulus to take of the hash of the source label values.
			modulus?: int64 & int

			// Regular expression against which the extracted value is matched. Default is '(.*)'
			// victoriaMetrics supports multiline regex joined with |
			// https://docs.victoriametrics.com/victoriametrics/vmagent/#relabeling-enhancements
			regex?: null | bool | number | string | [...] | {
				...
			}

			// Replacement value against which a regex replace is performed if the
			// regular expression matches. Regex capture groups are available. Default is '$1'
			replacement?: string

			// Separator placed between concatenated source label values. default is ';'.
			separator?: string

			// UnderScoreSourceLabels - additional form of source labels source_labels
			// for compatibility with original relabel config.
			// if set both sourceLabels and source_labels, sourceLabels has priority.
			// for details https://github.com/VictoriaMetrics/operator/issues/131
			source_labels?: [...string]

			// The source labels select values from existing labels. Their content is concatenated
			// using the configured separator and matched against the configured regular expression
			// for the replace, keep, and drop actions.
			sourceLabels?: [...string]

			// UnderScoreTargetLabel - additional form of target label - target_label
			// for compatibility with original relabel config.
			// if set both targetLabel and target_label, targetLabel has priority.
			// for details https://github.com/VictoriaMetrics/operator/issues/131
			target_label?: string

			// Label to which the resulting value is written in a replace action.
			// It is mandatory for replace actions. Regex capture groups are available.
			targetLabel?: string
		}]

		// ProbeSelector defines VMProbe to be selected for target probing.
		// Works in combination with NamespaceSelector.
		// NamespaceSelector nil - only objects at VMAgent or VMSingle namespace.
		// Selector nil - only objects at NamespaceSelector namespaces.
		// If both nil - behaviour controlled by selectAllByDefault
		probeSelector?: {
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

		// ReadinessGates defines pod readiness gates
		readinessGates?: [...{
			// ConditionType refers to a condition in the pod's condition list with matching type.
			conditionType!: string
		}]

		// ReadinessProbe that will be added to CR pod
		readinessProbe?: {
			...
		}

		// RelabelConfig ConfigMap with global relabel config -remoteWrite.relabelConfig
		// This relabeling is applied to all the collected metrics before sending them to remote storage.
		relabelConfig?: {
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

		// RemovePvcAfterDelete - if true, controller adds ownership to pvc
		// and after VMSingle object deletion - pvc will be garbage collected
		// by controller manager
		removePvcAfterDelete?: bool

		// ReplicaCount is the expected size of the Application.
		replicaCount?: int32 & int

		// Resources container resource request and limits,
		// https://kubernetes.io/docs/concepts/configuration/manage-resources-containers/
		// if not defined default resources from operator config will be used
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

		// RetentionFilters defines per-series retention filters for VMSingle.
		// Requires enterprise license. See
		// https://docs.victoriametrics.com/victoriametrics/single-server-victoriametrics/#retention-filters
		retentionFilters?: [...{
			// Filter is a MetricsQL label filter for matching time series.
			// Example: '{env="dev"}'
			filter!: string

			// Retention is the retention period for matching time series.
			// Must not exceed the global retentionPeriod.
			// Example: "3d", "1w"
			retention!: string
		}]

		// RetentionPeriod defines how long to retain stored metrics, specified as a
		// duration (e.g., "1d", "1w", "1m").
		// Data with timestamps outside the RetentionPeriod is automatically deleted.
		// The minimum allowed value is 1d, or 24h.
		// The default value is 1 (one month).
		// See
		// [retention](https://docs.victoriametrics.com/victoriametrics/single-server-victoriametrics/#retention)
		// docs for details.
		retentionPeriod?: =~"^[0-9]+(h|d|w|y)?$"

		// The number of old ReplicaSets to retain to allow rollback in deployment or
		// maximum number of revisions that will be maintained in the Deployment revision history.
		// Has no effect at StatefulSets
		// Defaults to 10.
		revisionHistoryLimitCount?: int32 & int

		// RuntimeClassName - defines runtime class for kubernetes pod.
		// https://kubernetes.io/docs/concepts/containers/runtime-class/
		runtimeClassName?: string

		// SampleLimit defines global per target limit of scraped samples
		sampleLimit?: int

		// SchedulerName - defines kubernetes scheduler name
		schedulerName?: string

		// ScrapeClasses defines the list of scrape classes to expose to scraping objects such as
		// PodScrapes, ServiceScrapes, Probes and ScrapeConfigs.
		scrapeClasses?: [...{
			// AttachMetadata defines additional metadata to the discovered targets.
			// When the scrape object defines its own configuration, it takes
			// precedence over the scrape class configuration.
			attachMetadata?: {
				// Namespace instructs vmagent or vmsingle to add namespace specific metadata from service discovery
				// Valid for roles: pod, service, endpoints, endpointslice, ingress.
				namespace?: bool

				// Node instructs vmagent or vmsingle to add node specific metadata from service discovery
				// Valid for roles: pod, endpoints, endpointslice.
				node?: bool
			}

			// Authorization with http header Authorization
			authorization?: {
				// Reference to the secret with value for authorization
				credentials?: {
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

				// File with value for authorization
				credentialsFile?: string

				// Type of authorization, default to bearer
				type?: string
			}

			// BasicAuth allow an endpoint to authenticate over basic authentication
			basicAuth?: {
				// Password defines reference for secret with password value
				// The secret needs to be in the same namespace as scrape object
				password?: {
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

				// PasswordFile defines path to password file at disk
				// must be pre-mounted
				password_file?: string

				// Username defines reference for secret with username value
				// The secret needs to be in the same namespace as scrape object
				username?: {
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

			// File to read bearer token for scraping targets.
			bearerTokenFile?: string

			// Secret to mount to read bearer token for scraping targets. The secret
			// needs to be in the same namespace as the scrape object and accessible by
			// the victoria-metrics operator.
			bearerTokenSecret?:
				null | {
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

			// default defines that the scrape applies to all scrape objects that
			// don't configure an explicit scrape class name.
			//
			// Only one scrape class can be set as the default.
			default?: bool

			// MetricRelabelConfigs to apply to samples after scrapping.
			metricRelabelConfigs?: [...{
				// Action to perform based on regex matching. Default is 'replace'
				action?: string

				// If represents metricsQL match expression (or list of expressions): '{__name__=~"foo_.*"}'
				if?: null | bool | number | string | [...] | {
					...
				}

				// Labels is used together with Match for `action: graphite`
				labels?: [string]: string

				// Match is used together with Labels for `action: graphite`
				match?: string

				// Modulus to take of the hash of the source label values.
				modulus?: int64 & int

				// Regular expression against which the extracted value is matched. Default is '(.*)'
				// victoriaMetrics supports multiline regex joined with |
				// https://docs.victoriametrics.com/victoriametrics/vmagent/#relabeling-enhancements
				regex?: null | bool | number | string | [...] | {
					...
				}

				// Replacement value against which a regex replace is performed if the
				// regular expression matches. Regex capture groups are available. Default is '$1'
				replacement?: string

				// Separator placed between concatenated source label values. default is ';'.
				separator?: string

				// UnderScoreSourceLabels - additional form of source labels source_labels
				// for compatibility with original relabel config.
				// if set both sourceLabels and source_labels, sourceLabels has priority.
				// for details https://github.com/VictoriaMetrics/operator/issues/131
				source_labels?: [...string]

				// The source labels select values from existing labels. Their content is concatenated
				// using the configured separator and matched against the configured regular expression
				// for the replace, keep, and drop actions.
				sourceLabels?: [...string]

				// UnderScoreTargetLabel - additional form of target label - target_label
				// for compatibility with original relabel config.
				// if set both targetLabel and target_label, targetLabel has priority.
				// for details https://github.com/VictoriaMetrics/operator/issues/131
				target_label?: string

				// Label to which the resulting value is written in a replace action.
				// It is mandatory for replace actions. Regex capture groups are available.
				targetLabel?: string
			}]

			// name of the scrape class.
			name!: strings.MinRunes(
				1)

			// OAuth2 defines auth configuration
			oauth2?: {
				// The secret or configmap containing the OAuth2 client id
				client_id!: {
					// ConfigMap containing data to use for the targets.
					configMap?: {
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

					// Secret containing data to use for the targets.
					secret?: {
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

				// The secret containing the OAuth2 client secret
				client_secret?: {
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

				// ClientSecretFile defines path for client secret file.
				client_secret_file?: string

				// Parameters to append to the token URL
				endpoint_params?: [string]: string

				// The proxy URL for token_url connection
				// Is only supported by Scrape objects family
				proxy_url?: string

				// OAuth2 scopes used for the token request
				scopes?: [...string]

				// TLSConfig for token_url connection
				// Is only supported by Scrape objects family
				tls_config?: null | bool | number | string | [...] | {
					...
				}

				// The URL to fetch the token from
				token_url!: strings.MinRunes(
						1)
			}

			// RelabelConfigs to apply to samples during service discovery.
			relabelConfigs?: [...{
				// Action to perform based on regex matching. Default is 'replace'
				action?: string

				// If represents metricsQL match expression (or list of expressions): '{__name__=~"foo_.*"}'
				if?: null | bool | number | string | [...] | {
					...
				}

				// Labels is used together with Match for `action: graphite`
				labels?: [string]: string

				// Match is used together with Labels for `action: graphite`
				match?: string

				// Modulus to take of the hash of the source label values.
				modulus?: int64 & int

				// Regular expression against which the extracted value is matched. Default is '(.*)'
				// victoriaMetrics supports multiline regex joined with |
				// https://docs.victoriametrics.com/victoriametrics/vmagent/#relabeling-enhancements
				regex?: null | bool | number | string | [...] | {
					...
				}

				// Replacement value against which a regex replace is performed if the
				// regular expression matches. Regex capture groups are available. Default is '$1'
				replacement?: string

				// Separator placed between concatenated source label values. default is ';'.
				separator?: string

				// UnderScoreSourceLabels - additional form of source labels source_labels
				// for compatibility with original relabel config.
				// if set both sourceLabels and source_labels, sourceLabels has priority.
				// for details https://github.com/VictoriaMetrics/operator/issues/131
				source_labels?: [...string]

				// The source labels select values from existing labels. Their content is concatenated
				// using the configured separator and matched against the configured regular expression
				// for the replace, keep, and drop actions.
				sourceLabels?: [...string]

				// UnderScoreTargetLabel - additional form of target label - target_label
				// for compatibility with original relabel config.
				// if set both targetLabel and target_label, targetLabel has priority.
				// for details https://github.com/VictoriaMetrics/operator/issues/131
				target_label?: string

				// Label to which the resulting value is written in a replace action.
				// It is mandatory for replace actions. Regex capture groups are available.
				targetLabel?: string
			}]

			// TLSConfig configuration to use when scraping the endpoint
			tlsConfig?: {
				// Struct containing the CA cert to use for the targets.
				ca?: {
					// ConfigMap containing data to use for the targets.
					configMap?: {
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

					// Secret containing data to use for the targets.
					secret?: {
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

				// Path to the CA cert in the container to use for the targets.
				caFile?: string

				// Struct containing the client cert file for the targets.
				cert?: {
					// ConfigMap containing data to use for the targets.
					configMap?: {
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

					// Secret containing data to use for the targets.
					secret?: {
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

				// Path to the client cert file in the container for the targets.
				certFile?: string

				// Disable target certificate validation.
				insecureSkipVerify?: bool

				// Path to the client key file in the container for the targets.
				keyFile?: string

				// Secret containing the client key file for the targets.
				keySecret?: {
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

				// Used to verify the hostname for the targets.
				serverName?: string
			}
		}]

		// ScrapeConfigNamespaceSelector defines Namespaces to be selected for VMScrapeConfig discovery.
		// Works in combination with Selector.
		// NamespaceSelector nil - only objects at VMAgent or VMSingle namespace.
		// Selector nil - only objects at NamespaceSelector namespaces.
		// If both nil - behaviour controlled by selectAllByDefault
		scrapeConfigNamespaceSelector?: {
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

		// ScrapeConfigRelabelTemplate defines relabel config, that will be added to each VMScrapeConfig.
		// it's useful for adding specific labels to all targets
		scrapeConfigRelabelTemplate?: [...{
			// Action to perform based on regex matching. Default is 'replace'
			action?: string

			// If represents metricsQL match expression (or list of expressions): '{__name__=~"foo_.*"}'
			if?: null | bool | number | string | [...] | {
				...
			}

			// Labels is used together with Match for `action: graphite`
			labels?: [string]: string

			// Match is used together with Labels for `action: graphite`
			match?: string

			// Modulus to take of the hash of the source label values.
			modulus?: int64 & int

			// Regular expression against which the extracted value is matched. Default is '(.*)'
			// victoriaMetrics supports multiline regex joined with |
			// https://docs.victoriametrics.com/victoriametrics/vmagent/#relabeling-enhancements
			regex?: null | bool | number | string | [...] | {
				...
			}

			// Replacement value against which a regex replace is performed if the
			// regular expression matches. Regex capture groups are available. Default is '$1'
			replacement?: string

			// Separator placed between concatenated source label values. default is ';'.
			separator?: string

			// UnderScoreSourceLabels - additional form of source labels source_labels
			// for compatibility with original relabel config.
			// if set both sourceLabels and source_labels, sourceLabels has priority.
			// for details https://github.com/VictoriaMetrics/operator/issues/131
			source_labels?: [...string]

			// The source labels select values from existing labels. Their content is concatenated
			// using the configured separator and matched against the configured regular expression
			// for the replace, keep, and drop actions.
			sourceLabels?: [...string]

			// UnderScoreTargetLabel - additional form of target label - target_label
			// for compatibility with original relabel config.
			// if set both targetLabel and target_label, targetLabel has priority.
			// for details https://github.com/VictoriaMetrics/operator/issues/131
			target_label?: string

			// Label to which the resulting value is written in a replace action.
			// It is mandatory for replace actions. Regex capture groups are available.
			targetLabel?: string
		}]

		// ScrapeConfigSelector defines VMScrapeConfig to be selected for target discovery.
		// Works in combination with NamespaceSelector.
		scrapeConfigSelector?: {
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

		// ScrapeInterval defines how often scrape targets by default
		scrapeInterval?: =~"[0-9]+(ms|s|m|h)"

		// ScrapeTimeout defines global timeout for targets scrape
		scrapeTimeout?: =~"[0-9]+(ms|s|m|h)"

		// Secrets is a list of Secrets in the same namespace as the Application
		// object, which shall be mounted into the Application container
		// at /etc/vm/secrets/SECRET_NAME folder
		secrets?: [...string]

		// SecurityContext holds pod-level security attributes and common container settings.
		// This defaults to the default PodSecurityContext.
		securityContext?: {
			...
		}

		// SelectAllByDefault changes default behavior for empty CRD selectors, such ServiceScrapeSelector.
		// with selectAllByDefault: true and empty serviceScrapeSelector and ServiceScrapeNamespaceSelector
		// Operator selects all exist serviceScrapes
		// with selectAllByDefault: false - selects nothing
		selectAllByDefault?: bool

		// ServiceAccountName is the name of the ServiceAccount to use to run the pods
		serviceAccountName?: string

		// ServiceScrapeNamespaceSelector Namespaces to be selected for VMServiceScrape discovery.
		// Works in combination with Selector.
		// NamespaceSelector nil - only objects at VMAgent or VMSingle namespace.
		// Selector nil - only objects at NamespaceSelector namespaces.
		// If both nil - behaviour controlled by selectAllByDefault
		serviceScrapeNamespaceSelector?: {
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

		// ServiceScrapeRelabelTemplate defines relabel config, that will be added to each VMServiceScrape.
		// it's useful for adding specific labels to all targets
		serviceScrapeRelabelTemplate?: [...{
			// Action to perform based on regex matching. Default is 'replace'
			action?: string

			// If represents metricsQL match expression (or list of expressions): '{__name__=~"foo_.*"}'
			if?: null | bool | number | string | [...] | {
				...
			}

			// Labels is used together with Match for `action: graphite`
			labels?: [string]: string

			// Match is used together with Labels for `action: graphite`
			match?: string

			// Modulus to take of the hash of the source label values.
			modulus?: int64 & int

			// Regular expression against which the extracted value is matched. Default is '(.*)'
			// victoriaMetrics supports multiline regex joined with |
			// https://docs.victoriametrics.com/victoriametrics/vmagent/#relabeling-enhancements
			regex?: null | bool | number | string | [...] | {
				...
			}

			// Replacement value against which a regex replace is performed if the
			// regular expression matches. Regex capture groups are available. Default is '$1'
			replacement?: string

			// Separator placed between concatenated source label values. default is ';'.
			separator?: string

			// UnderScoreSourceLabels - additional form of source labels source_labels
			// for compatibility with original relabel config.
			// if set both sourceLabels and source_labels, sourceLabels has priority.
			// for details https://github.com/VictoriaMetrics/operator/issues/131
			source_labels?: [...string]

			// The source labels select values from existing labels. Their content is concatenated
			// using the configured separator and matched against the configured regular expression
			// for the replace, keep, and drop actions.
			sourceLabels?: [...string]

			// UnderScoreTargetLabel - additional form of target label - target_label
			// for compatibility with original relabel config.
			// if set both targetLabel and target_label, targetLabel has priority.
			// for details https://github.com/VictoriaMetrics/operator/issues/131
			target_label?: string

			// Label to which the resulting value is written in a replace action.
			// It is mandatory for replace actions. Regex capture groups are available.
			targetLabel?: string
		}]

		// ServiceScrapeSelector defines ServiceScrapes to be selected for target discovery.
		// Works in combination with NamespaceSelector.
		// NamespaceSelector nil - only objects at VMAgent or VMSingle namespace.
		// Selector nil - only objects at NamespaceSelector namespaces.
		// If both nil - behaviour controlled by selectAllByDefault
		serviceScrapeSelector?: {
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

		// ServiceScrapeSpec that will be added to vmsingle VMServiceScrape spec
		serviceScrapeSpec?: {
			...
		}

		// ServiceSpec that will be added to vmsingle service spec
		serviceSpec?: {
			// EmbeddedObjectMetadata defines objectMeta for additional service.
			metadata?: {
				// Annotations is an unstructured key value map stored with a resource that may be
				// set by external tools to store and retrieve arbitrary metadata. They are not
				// queryable and should be preserved when modifying objects.
				// More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/annotations
				annotations?: [string]: string

				// Labels Map of string keys and values that can be used to organize and categorize
				// (scope and select) objects. May match selectors of replication controllers
				// and services.
				// More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/labels
				labels?: [string]: string

				// Name must be unique within a namespace. Is required when creating resources, although
				// some resources may allow a client to request the generation of an appropriate name
				// automatically. Name is primarily intended for creation idempotence and configuration
				// definition.
				// Cannot be updated.
				// More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names#names
				name?: string
			}

			// ServiceSpec describes the attributes that a user creates on a service.
			// More info: https://kubernetes.io/docs/concepts/services-networking/service/
			spec!: {
				...
			}

			// UseAsDefault applies changes from given service definition to the main object Service
			// Changing from headless service to clusterIP or loadbalancer may break
			// cross-component communication
			useAsDefault?: bool
		}

		// StartupProbe that will be added to CR pod
		startupProbe?: {
			...
		}

		// StaticScrapeNamespaceSelector defines Namespaces to be selected for VMStaticScrape discovery.
		// Works in combination with NamespaceSelector.
		// NamespaceSelector nil - only objects at VMAgent or VMSingle namespace.
		// Selector nil - only objects at NamespaceSelector namespaces.
		// If both nil - behaviour controlled by selectAllByDefault
		staticScrapeNamespaceSelector?: {
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

		// StaticScrapeRelabelTemplate defines relabel config, that will be added to each VMStaticScrape.
		// it's useful for adding specific labels to all targets
		staticScrapeRelabelTemplate?: [...{
			// Action to perform based on regex matching. Default is 'replace'
			action?: string

			// If represents metricsQL match expression (or list of expressions): '{__name__=~"foo_.*"}'
			if?: null | bool | number | string | [...] | {
				...
			}

			// Labels is used together with Match for `action: graphite`
			labels?: [string]: string

			// Match is used together with Labels for `action: graphite`
			match?: string

			// Modulus to take of the hash of the source label values.
			modulus?: int64 & int

			// Regular expression against which the extracted value is matched. Default is '(.*)'
			// victoriaMetrics supports multiline regex joined with |
			// https://docs.victoriametrics.com/victoriametrics/vmagent/#relabeling-enhancements
			regex?: null | bool | number | string | [...] | {
				...
			}

			// Replacement value against which a regex replace is performed if the
			// regular expression matches. Regex capture groups are available. Default is '$1'
			replacement?: string

			// Separator placed between concatenated source label values. default is ';'.
			separator?: string

			// UnderScoreSourceLabels - additional form of source labels source_labels
			// for compatibility with original relabel config.
			// if set both sourceLabels and source_labels, sourceLabels has priority.
			// for details https://github.com/VictoriaMetrics/operator/issues/131
			source_labels?: [...string]

			// The source labels select values from existing labels. Their content is concatenated
			// using the configured separator and matched against the configured regular expression
			// for the replace, keep, and drop actions.
			sourceLabels?: [...string]

			// UnderScoreTargetLabel - additional form of target label - target_label
			// for compatibility with original relabel config.
			// if set both targetLabel and target_label, targetLabel has priority.
			// for details https://github.com/VictoriaMetrics/operator/issues/131
			target_label?: string

			// Label to which the resulting value is written in a replace action.
			// It is mandatory for replace actions. Regex capture groups are available.
			targetLabel?: string
		}]

		// StaticScrapeSelector defines VMStaticScrape to be selected for target discovery.
		// Works in combination with NamespaceSelector.
		// If both nil - match everything.
		// NamespaceSelector nil - only objects at VMAgent or VMSingle namespace.
		// Selector nil - only objects at NamespaceSelector namespaces.
		staticScrapeSelector?: {
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

		// Storage is the definition of how storage will be used by the VMSingle
		// by default it`s empty dir
		storage?: {
			// accessModes contains the desired access modes the volume should have.
			// More info: https://kubernetes.io/docs/concepts/storage/persistent-volumes#access-modes-1
			accessModes?: [...string]

			// dataSource field can be used to specify either:
			// * An existing VolumeSnapshot object (snapshot.storage.k8s.io/VolumeSnapshot)
			// * An existing PVC (PersistentVolumeClaim)
			// If the provisioner or an external controller can support the specified data source,
			// it will create a new volume based on the contents of the specified data source.
			// dataSource contents will be copied to dataSourceRef, and dataSourceRef contents will be
			// copied to dataSource when dataSourceRef.namespace is not specified.
			// If the namespace is specified, then dataSourceRef will not be copied to dataSource.
			dataSource?: {
				// APIGroup is the group for the resource being referenced.
				// If APIGroup is not specified, the specified Kind must be in the core API group.
				// For any other third-party types, APIGroup is required.
				apiGroup?: string

				// Kind is the type of resource being referenced
				kind!: string

				// Name is the name of resource being referenced
				name!: string
			}

			// dataSourceRef specifies the object from which to populate the volume with data, if a non-empty
			// volume is desired. This may be any object from a non-empty API group (non
			// core object) or a PersistentVolumeClaim object.
			// When this field is specified, volume binding will only succeed if the type of
			// the specified object matches some installed volume populator or dynamic
			// provisioner.
			// This field will replace the functionality of the dataSource field and as such
			// if both fields are non-empty, they must have the same value. For backwards
			// compatibility, when namespace isn't specified in dataSourceRef,
			// both fields (dataSource and dataSourceRef) will be set to the same
			// value automatically if one of them is empty and the other is non-empty.
			// When namespace is specified in dataSourceRef,
			// dataSource isn't set to the same value and must be empty.
			// There are three important differences between dataSource and dataSourceRef:
			// * While dataSource only allows two specific types of objects, dataSourceRef
			// allows any non-core object, as well as PersistentVolumeClaim objects.
			// * While dataSource ignores disallowed values (dropping them), dataSourceRef
			// preserves all values, and generates an error if a disallowed value is
			// specified.
			// * While dataSource only allows local objects, dataSourceRef allows objects
			// in any namespaces.
			// (Alpha) Using the namespace field of dataSourceRef requires the
			// CrossNamespaceVolumeDataSource feature gate to be enabled.
			dataSourceRef?: {
				// APIGroup is the group for the resource being referenced.
				// If APIGroup is not specified, the specified Kind must be in the core API group.
				// For any other third-party types, APIGroup is required.
				apiGroup?: string

				// Kind is the type of resource being referenced
				kind!: string

				// Name is the name of resource being referenced
				name!: string

				// Namespace is the namespace of resource being referenced
				// Note that when a namespace is specified, a
				// gateway.networking.k8s.io/ReferenceGrant object is required in the referent
				// namespace to allow that namespace's owner to accept the reference. See the
				// ReferenceGrant documentation for details.
				// (Alpha) This field requires the CrossNamespaceVolumeDataSource feature gate to be enabled.
				namespace?: string
			}

			// resources represents the minimum resources the volume should have.
			// Users are allowed to specify resource requirements
			// that are lower than previous value but must still be higher than capacity recorded in the
			// status field of the claim.
			// More info: https://kubernetes.io/docs/concepts/storage/persistent-volumes#resources
			resources?: {
				// Limits describes the maximum amount of compute resources allowed.
				// More info: https://kubernetes.io/docs/concepts/configuration/manage-resources-containers/
				limits?: [string]: matchN(>=1, [int, string]) & (int | =~"^(\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))(([KMGTPE]i)|[numkMGTPE]|([eE](\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))))?$")

				// Requests describes the minimum amount of compute resources required.
				// If Requests is omitted for a container, it defaults to Limits if that is explicitly specified,
				// otherwise to an implementation-defined value. Requests cannot exceed Limits.
				// More info: https://kubernetes.io/docs/concepts/configuration/manage-resources-containers/
				requests?: [string]: matchN(>=1, [int, string]) & (int | =~"^(\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))(([KMGTPE]i)|[numkMGTPE]|([eE](\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))))?$")
			}

			// selector is a label query over volumes to consider for binding.
			selector?: {
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

			// storageClassName is the name of the StorageClass required by the claim.
			// More info: https://kubernetes.io/docs/concepts/storage/persistent-volumes#class-1
			storageClassName?: string

			// volumeAttributesClassName may be used to set the VolumeAttributesClass used by this claim.
			// If specified, the CSI driver will create or update the volume with the attributes defined
			// in the corresponding VolumeAttributesClass. This has a different purpose than storageClassName,
			// it can be changed after the claim is created. An empty string or nil value indicates that no
			// VolumeAttributesClass will be applied to the claim. If the claim enters an
			// Infeasible error state,
			// this field can be reset to its previous value (including nil) to cancel the modification.
			// If the resource referred to by volumeAttributesClass does not exist, this
			// PersistentVolumeClaim will be
			// set to a Pending state, as reflected by the modifyVolumeStatus field, until such as a resource
			// exists.
			// More info: https://kubernetes.io/docs/concepts/storage/volume-attributes-classes/
			volumeAttributesClassName?: string

			// volumeMode defines what type of volume is required by the claim.
			// Value of Filesystem is implied when not included in claim spec.
			volumeMode?: string

			// volumeName is the binding reference to the PersistentVolume backing this claim.
			volumeName?: string
		}

		// StorageDataPath overrides the default mount path used for the `data` volume and the arg
		// for victoria-metrics binary --storageDataPath. If spec.storage is set, its PVC is mounted
		// at this path instead of the default one; otherwise it's the user's responsibility to mount
		// a proper device into the given path via spec.volumes and spec.volumeMounts.
		// It requires to provide spec.volumes and spec.volumeMounts with at least 1 value
		storageDataPath?: string

		// StorageMeta defines annotations and labels attached to PVC for given vmsingle CR
		storageMetadata?: {
			// Annotations is an unstructured key value map stored with a resource that may be
			// set by external tools to store and retrieve arbitrary metadata. They are not
			// queryable and should be preserved when modifying objects.
			// More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/annotations
			annotations?: [string]: string

			// Labels Map of string keys and values that can be used to organize and categorize
			// (scope and select) objects. May match selectors of replication controllers
			// and services.
			// More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/labels
			labels?: [string]: string

			// Name must be unique within a namespace. Is required when creating resources, although
			// some resources may allow a client to request the generation of an appropriate name
			// automatically. Name is primarily intended for creation idempotence and configuration
			// definition.
			// Cannot be updated.
			// More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names#names
			name?: string
		}

		// StreamAggrConfig defines stream aggregation configuration for VMSingle
		streamAggrConfig?: {
			// ConfigMap with stream aggregation rules
			configmap?: {
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

			// Allows setting different de-duplication intervals per each configured remote storage
			dedupInterval?: string

			// Allow drop all the input samples after the aggregation
			dropInput?: bool

			// labels to drop from samples for aggregator before stream de-duplication and aggregation
			dropInputLabels?: [...string]

			// EnableWindows enables aggregating data in separate windows.
			enableWindows?: bool

			// IgnoreFirstIntervals instructs to ignore first interval
			ignoreFirstIntervals?: int

			// IgnoreFirstSampleInterval sets interval for total and prometheus_total during
			// which first samples will be ignored
			ignoreFirstSampleInterval?: string

			// IgnoreOldSamples instructs to ignore samples with old timestamps outside the
			// current aggregation interval.
			ignoreOldSamples?: bool

			// Allows writing both raw and aggregate data
			keepInput?: bool

			// Stream aggregation rules
			rules?: [...{
				// By is an optional list of labels for grouping input series.
				//
				// See also Without.
				//
				// If neither By nor Without are set, then the Outputs are calculated
				// individually per each input time series.
				by?: [...string]

				// DedupInterval is an optional interval for deduplication.
				dedup_interval?: string

				// DropInputLabels is an optional list with labels, which must be dropped before
				// further processing of input samples.
				//
				// Labels are dropped before de-duplication and aggregation.
				drop_input_labels?: [...string]

				// EnableWindows enables aggregating data in separate windows
				enable_windows?: bool

				// FlushOnShutdown defines whether to flush the aggregation state on process termination
				// or config reload. Is `false` by default.
				// It is not recommended changing this setting, unless unfinished aggregations states
				// are preferred to missing data points.
				flush_on_shutdown?:      bool
				ignore_first_intervals?: int

				// IgnoreOldSamples instructs to ignore samples with old timestamps outside the
				// current aggregation interval.
				ignore_old_samples?: bool

				// IgnoreFirstSampleInterval sets interval for total and prometheus_total during
				// which first samples will be ignored
				ignoreFirstSampleInterval?: string

				// InputRelabelConfigs is an optional relabeling rules, which are applied on the input
				// before aggregation.
				input_relabel_configs?: [...{
					// Action to perform based on regex matching. Default is 'replace'
					action?: string

					// If represents metricsQL match expression (or list of expressions): '{__name__=~"foo_.*"}'
					if?: null | bool | number | string | [...] | {
						...
					}

					// Labels is used together with Match for `action: graphite`
					labels?: [string]: string

					// Match is used together with Labels for `action: graphite`
					match?: string

					// Modulus to take of the hash of the source label values.
					modulus?: int64 & int

					// Regular expression against which the extracted value is matched. Default is '(.*)'
					// victoriaMetrics supports multiline regex joined with |
					// https://docs.victoriametrics.com/victoriametrics/vmagent/#relabeling-enhancements
					regex?: null | bool | number | string | [...] | {
						...
					}

					// Replacement value against which a regex replace is performed if the
					// regular expression matches. Regex capture groups are available. Default is '$1'
					replacement?: string

					// Separator placed between concatenated source label values. default is ';'.
					separator?: string

					// UnderScoreSourceLabels - additional form of source labels source_labels
					// for compatibility with original relabel config.
					// if set both sourceLabels and source_labels, sourceLabels has priority.
					// for details https://github.com/VictoriaMetrics/operator/issues/131
					source_labels?: [...string]

					// The source labels select values from existing labels. Their content is concatenated
					// using the configured separator and matched against the configured regular expression
					// for the replace, keep, and drop actions.
					sourceLabels?: [...string]

					// UnderScoreTargetLabel - additional form of target label - target_label
					// for compatibility with original relabel config.
					// if set both targetLabel and target_label, targetLabel has priority.
					// for details https://github.com/VictoriaMetrics/operator/issues/131
					target_label?: string

					// Label to which the resulting value is written in a replace action.
					// It is mandatory for replace actions. Regex capture groups are available.
					targetLabel?: string
				}]

				// Interval is the interval between aggregations.
				interval!: string

				// KeepMetricNames instructs to leave metric names as is for the output time
				// series without adding any suffix.
				keep_metric_names?: bool

				// Match is a label selector (or list of label selectors) for filtering time
				// series for the given selector.
				//
				// If the match isn't set, then all the input time series are processed.
				match?: null | bool | number | string | [...] | {
					...
				}

				// NoAlignFlushToInterval disables aligning of flushes to multiples of Interval.
				// By default flushes are aligned to Interval.
				no_align_flush_to_interval?: bool

				// OutputRelabelConfigs is an optional relabeling rules, which are applied
				// on the aggregated output before being sent to remote storage.
				output_relabel_configs?: [...{
					// Action to perform based on regex matching. Default is 'replace'
					action?: string

					// If represents metricsQL match expression (or list of expressions): '{__name__=~"foo_.*"}'
					if?: null | bool | number | string | [...] | {
						...
					}

					// Labels is used together with Match for `action: graphite`
					labels?: [string]: string

					// Match is used together with Labels for `action: graphite`
					match?: string

					// Modulus to take of the hash of the source label values.
					modulus?: int64 & int

					// Regular expression against which the extracted value is matched. Default is '(.*)'
					// victoriaMetrics supports multiline regex joined with |
					// https://docs.victoriametrics.com/victoriametrics/vmagent/#relabeling-enhancements
					regex?: null | bool | number | string | [...] | {
						...
					}

					// Replacement value against which a regex replace is performed if the
					// regular expression matches. Regex capture groups are available. Default is '$1'
					replacement?: string

					// Separator placed between concatenated source label values. default is ';'.
					separator?: string

					// UnderScoreSourceLabels - additional form of source labels source_labels
					// for compatibility with original relabel config.
					// if set both sourceLabels and source_labels, sourceLabels has priority.
					// for details https://github.com/VictoriaMetrics/operator/issues/131
					source_labels?: [...string]

					// The source labels select values from existing labels. Their content is concatenated
					// using the configured separator and matched against the configured regular expression
					// for the replace, keep, and drop actions.
					sourceLabels?: [...string]

					// UnderScoreTargetLabel - additional form of target label - target_label
					// for compatibility with original relabel config.
					// if set both targetLabel and target_label, targetLabel has priority.
					// for details https://github.com/VictoriaMetrics/operator/issues/131
					target_label?: string

					// Label to which the resulting value is written in a replace action.
					// It is mandatory for replace actions. Regex capture groups are available.
					targetLabel?: string
				}]

				// Outputs is a list of output aggregate functions to produce.
				//
				// The following names are allowed:
				//
				// - total - aggregates input counters
				// - increase - counts the increase over input counters
				// - count_series - counts the input series
				// - count_samples - counts the input samples
				// - sum_samples - sums the input samples
				// - last - the last biggest sample value
				// - min - the minimum sample value
				// - max - the maximum sample value
				// - avg - the average value across all the samples
				// - stddev - standard deviation across all the samples
				// - stdvar - standard variance across all the samples
				// - histogram_bucket - creates VictoriaMetrics histogram for input samples
				// - quantiles(phi1, ..., phiN) - quantiles' estimation for phi in the range [0..1]
				//
				// The output time series will have the following names:
				//
				// input_name:aggr_<interval>_<output>
				outputs!: [...string]

				// Staleness interval is interval after which the series state will be reset if
				// no samples have been sent during it.
				// The parameter is only relevant for outputs: total, total_prometheus,
				// increase, increase_prometheus and histogram_bucket.
				staleness_interval?: string

				// Without is an optional list of labels, which must be excluded when grouping input series.
				//
				// See also By.
				//
				// If neither By nor Without are set, then the Outputs are calculated
				// individually per each input time series.
				without?: [...string]
			}]
		}

		// TerminationGracePeriodSeconds period for container graceful termination
		terminationGracePeriodSeconds?: int64 & int

		// Tolerations If specified, the pod's tolerations.
		tolerations?: [...{
			// Effect indicates the taint effect to match. Empty means match all taint effects.
			// When specified, allowed values are NoSchedule, PreferNoSchedule and NoExecute.
			effect?: string

			// Key is the taint key that the toleration applies to. Empty means match all taint keys.
			// If the key is empty, operator must be Exists; this combination means to match
			// all values and all keys.
			key?: string

			// Operator represents a key's relationship to the value.
			// Valid operators are Exists, Equal, Lt, and Gt. Defaults to Equal.
			// Exists is equivalent to wildcard for value, so that a pod can
			// tolerate all taints of a particular category.
			// Lt and Gt perform numeric comparisons (requires feature gate TaintTolerationComparisonOperators).
			operator?: string

			// TolerationSeconds represents the period of time the toleration (which must be
			// of effect NoExecute, otherwise this field is ignored) tolerates the taint. By default,
			// it is not set, which means tolerate the taint forever (do not evict). Zero and
			// negative values will be treated as 0 (evict immediately) by the system.
			tolerationSeconds?: int64 & int

			// Value is the taint value the toleration matches to.
			// If the operator is Exists, the value should be empty, otherwise just a regular string.
			value?: string
		}]

		// TopologySpreadConstraints embedded kubernetes pod configuration option,
		// controls how pods are spread across your cluster among failure-domains
		// such as regions, zones, nodes, and other user-defined topology domains
		// https://kubernetes.io/docs/concepts/workloads/pods/pod-topology-spread-constraints/
		topologySpreadConstraints?: [...{
			maxSkew!:           _
			topologyKey!:       _
			whenUnsatisfiable!: _
			...
		}]

		// UseDefaultResources controls resource settings
		// By default, operator sets built-in resource requirements
		useDefaultResources?: bool

		// UseLegacyNaming uses standalone Helm chart naming for managed resources:
		// the CR name is used directly instead of the default "<type>-<name>" convention.
		useLegacyNaming?: bool

		// UseStrictSecurity enables strict security mode for component
		// it restricts disk writes access
		// uses non-root user out of the box
		// drops not needed security permissions
		useStrictSecurity?: bool

		// UseVMConfigReloader replaces prometheus-like config-reloader
		// with vm one. It uses secrets watch instead of file watch
		// which greatly increases speed of config updates
		useVMConfigReloader?: bool

		// VMAgentExternalLabelName Name of vmAgent external label used to denote vmAgent instance
		// name. Defaults to the value of `prometheus`. External label will
		// _not_ be added when value is set to empty string (`""`).
		vmAgentExternalLabelName?: string

		// VMBackup configuration for backup
		vmBackup?: {
			// AcceptEULA accepts enterprise feature usage, must be set to true.
			// otherwise backupmanager cannot be added to single/cluster version.
			// https://victoriametrics.com/legal/esa/
			acceptEULA?: bool

			// Defines number of concurrent workers. Higher concurrency may reduce backup duration (default 10)
			concurrency?: int32 & int

			// CredentialsSecret is secret in the same namespace for access to remote storage
			// The secret is mounted into /etc/vm/creds.
			credentialsSecret?: {
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

			// Custom S3 endpoint for use with S3-compatible storages (e.g. MinIO). S3 is used if not set
			customS3Endpoint?: string

			// Defines destination for backup
			destination?: string

			// DestinationDisableSuffixAdd - disables suffix adding for cluster version backups
			// each vmstorage backup must have unique backup folder
			// so operator adds POD_NAME as suffix for backup destination folder.
			destinationDisableSuffixAdd?: bool

			// Defines if daily backups disabled (default false)
			disableDaily?: bool

			// Defines if hourly backups disabled (default false)
			disableHourly?: bool

			// Defines if monthly backups disabled (default false)
			disableMonthly?: bool

			// Defines if weekly backups disabled (default false)
			disableWeekly?: bool

			// extra args like maxBytesPerSecond default 0
			extraArgs?: [string]: string
			extraEnvs?: [...{
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

			// ExtraEnvsFrom defines source of env variables for the application container
			// could either be secret or configmap
			extraEnvsFrom?: [...{
				// The ConfigMap to select from
				configMapRef?: {
					// Name of the referent.
					// This field is effectively required, but due to backwards compatibility is
					// allowed to be empty. Instances of this type with an empty value here are
					// almost certainly wrong.
					// More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names
					name?: string

					// Specify whether the ConfigMap must be defined
					optional?: bool
				}

				// Optional text to prepend to the name of each environment variable.
				// May consist of any printable ASCII characters except '='.
				prefix?: string

				// The Secret to select from
				secretRef?: {
					// Name of the referent.
					// This field is effectively required, but due to backwards compatibility is
					// allowed to be empty. Instances of this type with an empty value here are
					// almost certainly wrong.
					// More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names
					name?: string

					// Specify whether the Secret must be defined
					optional?: bool
				}
			}]

			// Image - docker image settings for VMBackuper
			image?: {
				// PullPolicy describes how to pull docker image
				pullPolicy?: string

				// Repository contains name of docker image + it's repository if needed
				repository?: string

				// Tag contains desired docker image version.
				// It may be a regular tag (e.g. "v1.96.0") or a digest
				// (e.g. "sha256:<hex>"); a digest is joined to the repository with "@"
				// instead of ":", allowing images to be pinned by digest.
				tag?: string
			}

			// LogFormat for VMBackup to be configured with.
			// default or json
			logFormat?: "default" | "json"

			// LogLevel for VMBackup to be configured with.
			logLevel?: "INFO" | "WARN" | "ERROR" | "FATAL" | "PANIC"

			// Port for health check connections
			port?: string

			// Resources container resource request and limits,
			// https://kubernetes.io/docs/concepts/configuration/manage-resources-containers/
			// if not defined default resources from operator config will be used
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

			// Restore Allows to enable restore options for pod
			// Read [more](https://docs.victoriametrics.com/victoriametrics/vmbackupmanager/#restore-commands)
			restore?: {
				// OnStart defines configuration for restore on pod start
				onStart?: {
					// Enabled defines if restore on start enabled
					enabled?: bool
				}
			}

			// SnapshotCreateURL overwrites url for snapshot create
			snapshotCreateURL?: string

			// SnapshotDeleteURL overwrites url for snapshot delete
			snapshotDeleteURL?: string

			// VolumeMounts allows configuration of additional VolumeMounts on the output Deployment definition.
			// VolumeMounts specified will be appended to other VolumeMounts in the vmbackupmanager container,
			// that are generated as a result of StorageSpec objects.
			volumeMounts?: [...{
				// bindMountOptions is the list of additional bind mount options to apply when
				// mounting this volume into the container. Allowed values are noexec,
				// nodev, and nosuid. These are Linux mount options and have no effect on
				// Windows nodes.
				// This field is not supported with image volumes.
				// This is an alpha field and requires enabling the VolumeBindMountOptions feature gate.
				bindMountOptions?: [...string]

				// Path within the container at which the volume should be mounted.
				mountPath!: string

				// mountPropagation determines how mounts are propagated from the host
				// to container and the other way around.
				// When not set, MountPropagationNone is used.
				// This field is beta in 1.10.
				// When RecursiveReadOnly is set to IfPossible or to Enabled, MountPropagation
				// must be None or unspecified
				// (which defaults to None).
				mountPropagation?: string

				// This must match the Name of a Volume.
				name!: string

				// Mounted read-only if true, read-write otherwise (false or unspecified).
				// Defaults to false.
				readOnly?: bool

				// RecursiveReadOnly specifies whether read-only mounts should be handled
				// recursively.
				//
				// If ReadOnly is false, this field has no meaning and must be unspecified.
				//
				// If ReadOnly is true, and this field is set to Disabled, the mount is not made
				// recursively read-only. If this field is set to IfPossible, the mount is made
				// recursively read-only, if it is supported by the container runtime. If this
				// field is set to Enabled, the mount is made recursively read-only if it is
				// supported by the container runtime, otherwise the pod will not be started and
				// an error will be generated to indicate the reason.
				//
				// If this field is set to IfPossible or Enabled, MountPropagation must be set to
				// None (or be unspecified, which defaults to None).
				//
				// If this field is not specified, it is treated as an equivalent of Disabled.
				recursiveReadOnly?: string

				// Path within the volume from which the container's volume should be mounted.
				// Defaults to "" (volume's root).
				subPath?: string

				// Expanded path within the volume from which the container's volume should be mounted.
				// Behaves similarly to SubPath but environment variable references $(VAR_NAME)
				// are expanded using the container's environment.
				// Defaults to "" (volume's root).
				// SubPathExpr and SubPath are mutually exclusive.
				subPathExpr?: string
			}]
		}

		// VolumeMounts allows configuration of additional VolumeMounts on the output
		// Deployment/StatefulSet definition.
		// VolumeMounts specified will be appended to other VolumeMounts in the Application container
		volumeMounts?: [...{
			// bindMountOptions is the list of additional bind mount options to apply when
			// mounting this volume into the container. Allowed values are noexec,
			// nodev, and nosuid. These are Linux mount options and have no effect on
			// Windows nodes.
			// This field is not supported with image volumes.
			// This is an alpha field and requires enabling the VolumeBindMountOptions feature gate.
			bindMountOptions?: [...string]

			// Path within the container at which the volume should be mounted.
			mountPath!: string

			// mountPropagation determines how mounts are propagated from the host
			// to container and the other way around.
			// When not set, MountPropagationNone is used.
			// This field is beta in 1.10.
			// When RecursiveReadOnly is set to IfPossible or to Enabled, MountPropagation
			// must be None or unspecified
			// (which defaults to None).
			mountPropagation?: string

			// This must match the Name of a Volume.
			name!: string

			// Mounted read-only if true, read-write otherwise (false or unspecified).
			// Defaults to false.
			readOnly?: bool

			// RecursiveReadOnly specifies whether read-only mounts should be handled
			// recursively.
			//
			// If ReadOnly is false, this field has no meaning and must be unspecified.
			//
			// If ReadOnly is true, and this field is set to Disabled, the mount is not made
			// recursively read-only. If this field is set to IfPossible, the mount is made
			// recursively read-only, if it is supported by the container runtime. If this
			// field is set to Enabled, the mount is made recursively read-only if it is
			// supported by the container runtime, otherwise the pod will not be started and
			// an error will be generated to indicate the reason.
			//
			// If this field is set to IfPossible or Enabled, MountPropagation must be set to
			// None (or be unspecified, which defaults to None).
			//
			// If this field is not specified, it is treated as an equivalent of Disabled.
			recursiveReadOnly?: string

			// Path within the volume from which the container's volume should be mounted.
			// Defaults to "" (volume's root).
			subPath?: string

			// Expanded path within the volume from which the container's volume should be mounted.
			// Behaves similarly to SubPath but environment variable references $(VAR_NAME)
			// are expanded using the container's environment.
			// Defaults to "" (volume's root).
			// SubPathExpr and SubPath are mutually exclusive.
			subPathExpr?: string
		}]

		// Volumes allows configuration of additional volumes on the output
		// Deployment/StatefulSet definition.
		// Volumes specified will be appended to other volumes that are generated.
		volumes?: [...{
			name!: _
			...
		}]

		// Configures vertical pod autoscaling.
		vpa?: {
			// Recommenders specifies custom VPA recommender names.
			recommenders?: [...{
				// Name of the recommender responsible for generating recommendation for this object.
				name!: string
			}]

			// ResourcePolicy controls how the autoscaler computes recommended resources per container.
			resourcePolicy?: {
				// Per-container resource policies.
				containerPolicies?: [...{
					// Name of the container or DefaultContainerResourcePolicy, in which
					// case the policy is used by the containers that don't have their own
					// policy specified.
					containerName?: string

					// Specifies the type of recommendations that will be computed
					// (and possibly applied) by VPA.
					// If not specified, the default of [ResourceCPU, ResourceMemory] will be used.
					controlledResources?: [...string]

					// Specifies which resource values should be controlled.
					// The default is "RequestsAndLimits".
					controlledValues?: "RequestsAndLimits" | "RequestsOnly"

					// Specifies the maximum amount of resources that will be recommended
					// for the container. The default is no maximum.
					maxAllowed?: [string]: matchN(>=1, [int, string]) & (int | =~"^(\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))(([KMGTPE]i)|[numkMGTPE]|([eE](\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))))?$")

					// memoryAggregationIntervalCount is the number of consecutive
					// memoryAggregationIntervals which make up the memory aggregation window.
					// The total window length is:
					// MemoryAggregationIntervalSeconds * MemoryAggregationIntervalCount.
					memoryAggregationIntervalCount?: int64 & int & >=1

					// memoryAggregationIntervalSeconds is the length of a single interval
					// (in seconds) for which the peak memory usage is computed.
					// Memory usage peaks are aggregated in multiples of this interval.
					// In other words, there is one memory usage sample per interval
					// (the maximum usage over that interval).
					memoryAggregationIntervalSeconds?: int32 & int & >=1

					// Specifies the minimal amount of resources that will be recommended
					// for the container. The default is no minimum.
					minAllowed?: [string]: matchN(>=1, [int, string]) & (int | =~"^(\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))(([KMGTPE]i)|[numkMGTPE]|([eE](\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))))?$")

					// Whether autoscaler is enabled for the container. The default is "Auto".
					mode?: "Auto" | "Off"

					// oomBumpUpRatio is the ratio to increase memory when OOM is detected.
					oomBumpUpRatio?: matchN(>=1, [int, string]) & (int | =~"^(\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))(([KMGTPE]i)|[numkMGTPE]|([eE](\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))))?$")

					// oomMinBumpUp is the minimum increase in memory when OOM is detected.
					oomMinBumpUp?: matchN(>=1, [int, string]) & (int | =~"^(\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))(([KMGTPE]i)|[numkMGTPE]|([eE](\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))))?$")

					// startupBoost specifies the startup boost policy for the container.
					// This overrides any pod-level startup boost policy.
					// The startup boost policy takes precedence over the rest of the fields in
					// this struct, except for ContainerName and ControlledValues.
					startupBoost?: {
						// cpu specifies the CPU startup boost policy.
						// If this field is not set, no startup boost is applied.
						cpu?: {
							// durationSeconds indicates for how long to keep the pod boosted after it goes to Ready.
							// Defaults to 0.
							durationSeconds?: int32 & int

							// factor specifies the factor to apply to the resource request.
							// This field is required when Type is "Factor".
							factor?: int32 & int

							// quantity specifies the absolute resource quantity to be used as the
							// resource request and limit during the boost phase.
							// This field is required when Type is "Quantity".
							quantity?: matchN(>=1, [int, string]) & (int | =~"^(\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))(([KMGTPE]i)|[numkMGTPE]|([eE](\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))))?$")

							// type specifies the kind of boost to apply.
							// Supported values are: "Factor", "Quantity".
							// No startupboost will be applied for unrecognized values.
							type!: "Factor" | "Quantity"
						}
					}
				}]
			}

			// UpdatePolicy controls how the autoscaler applies changes to pod resources.
			updatePolicy?: {
				// evictAfterOOMSeconds specifies the time in seconds to wait after an OOM event before
				// considering the pod for eviction. Pods that have OOMed in less than this time
				// since start will be evicted.
				evictAfterOOMSeconds?: int32 & int & >=1

				// EvictionRequirements is a list of EvictionRequirements that need to
				// evaluate to true in order for a Pod to be evicted. If more than one
				// EvictionRequirement is specified, all of them need to be fulfilled to allow eviction.
				evictionRequirements?: [...{
					// EvictionChangeRequirement refers to the relationship between the new target
					// recommendation for a Pod and its current requests, what kind of change is
					// necessary for the Pod to be evicted
					changeRequirement!: "TargetHigherThanRequests" | "TargetLowerThanRequests"

					// Resources is a list of one or more resources that the condition applies
					// to. If more than one resource is given, the EvictionRequirement is fulfilled
					// if at least one resource meets `changeRequirement`.
					resources!: [...string]
				}]

				// Minimal number of replicas which need to be alive for Updater to attempt
				// pod eviction (pending other checks like PDB). Only positive values are
				// allowed. Overrides global '--min-replicas' flag.
				minReplicas?: int32 & int

				// Controls when autoscaler applies changes to the pod resources.
				// The default is 'Recreate'.
				updateMode?: "Off" | "Initial" | "Recreate" | "InPlaceOrRecreate" | "InPlace" | "Auto"
			}
		}
	}

	// VMSingleStatus defines the observed state of VMSingle
	status?: {
		// Known .status.conditions.type are: "Available", "Progressing", and "Degraded"
		conditions?: [...{
			// lastTransitionTime is the last time the condition transitioned from one status to another.
			lastTransitionTime!: time.Time

			// LastUpdateTime is the last time of given type update.
			// This value is used for status TTL update and removal
			lastUpdateTime!: time.Time

			// message is a human readable message indicating details about the transition.
			// This may be an empty string.
			message?: strings.MaxRunes(
					32768)

			// observedGeneration represents the .metadata.generation that the condition was set based upon.
			// For instance, if .metadata.generation is currently 12, but the
			// .status.conditions[x].observedGeneration is 9, the condition is out of date
			// with respect to the current state of the instance.
			observedGeneration?: int64 & int & >=0

			// reason contains a programmatic identifier indicating the reason for the
			// condition's last transition.
			// Producers of specific condition types may define expected values and meanings for this field,
			// and whether the values are considered a guaranteed API.
			// The value should be a CamelCase string.
			// This field may not be empty.
			reason!: strings.MaxRunes(
					1024) & strings.MinRunes(
					1)

			// status of the condition, one of True, False, Unknown.
			status!: "True" | "False" | "Unknown"

			// Type of condition in CamelCase or in name.namespace.resource.victoriametrics.com/CamelCase.
			type!: strings.MaxRunes(
				316)
		}]
		lastAppliedSpec?: null | bool | number | string | [...] | {
			...
		}

		// ObservedGeneration defines current generation picked by operator for the
		// reconcile
		observedGeneration?: int64 & int

		// Reason defines human readable error reason
		reason?: string

		// UpdateStatus defines a status for update rollout
		updateStatus?: string
	}

	_embeddedResource: {
		apiVersion!: string
		kind!:       string
		metadata?: {
			...
		}
	}
	apiVersion: "operator.victoriametrics.com/v1beta1"
	kind:       "VMSingle"
	metadata!: {
		name!:      string
		namespace!: string
		labels?: [string]: string
		annotations?: [string]: string
		...
	}
}
