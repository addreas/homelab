package v1alpha1

import (
	"strings"
	"time"
)

#VMDistributed: {
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

	// spec defines the desired state of VMDistributed
	spec!: {
		// BackendType defines the storage backend type used across all zones.
		// VMCluster uses a distributed VMCluster per zone; VMSingle uses a single-node VMSingle per zone.
		// All zones must use the same backend type; mixed configurations are not supported.
		backendType?: "VMCluster" | "VMSingle"

		// License configures license key for enterprise features. If not nil, it will
		// be passed to VMAgent, VMAuth and VMClusters.
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

		// Paused If set to true all actions on the underlying managed objects are not
		// going to be performed, except for delete actions.
		paused?: bool

		// Retain keeps resources in case of VMDistributed removal
		retain?: bool

		// VMAuth is a VMAuth definition (name + optional spec) that acts as a proxy for
		// the VMUsers created by the operator.
		// Use an inline spec to define a VMAuth object in-place or provide a name to
		// reference an existing VMAuth.
		vmauth?: {
			// Enabled defines if vmauth should be created.
			enabled?: bool

			// Name specifies the static name to be used for the DistributedAuth when Spec is provided.
			name?: string

			// Spec defines the desired state of a new VMAuth.
			spec?: {
				// Affinity If specified, the pod's scheduling constraints.
				affinity?: {
					...
				}

				// ArbitraryFSAccessThroughSMs configures whether configuration
				// can contain paths to arbitrary files on the file system
				// e.g bearer token files, basic auth password files, tls certs file paths
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

				// ConfigSecret is the name of a Kubernetes Secret in the same namespace as the
				// VMAuth object, which contains auth configuration for vmauth,
				// configuration must be inside secret key: config.yaml.
				// It must be created and managed manually.
				// If it's defined, configuration for vmauth becomes unmanaged and operator'll
				// not create any related secrets/config-reloaders
				configSecret?: string

				// Containers property allows to inject additions sidecars or to patch existing containers.
				// It can be useful for proxies, backup, etc.
				containers?: [...{
					name!: _
					...
				}]

				// DefaultTargetRefs list of named targetRefs, which may be referenced by VMUser
				// and at unauthorizedUserAccessSpec.
				defaultTargetRefs?: [...{
					// CRD describes exist operator's CRD object,
					// operator generates access url based on CRD params.
					crd?: {
						// Kind one of:
						// VMAgent,VMAlert, VMSingle, VMCluster/vmselect,
						// VMCluster/vmstorage,VMCluster/vminsert,VMAlertManager, VLSingle,
						// VLCluster/vlinsert, VLCluster/vlselect, VLCluster/vlstorage, VTSingle,
						// VTCluster/vtinsert, VTCluster/vtselect, VTCluster/vtstorage VMAnomaly and
						// VLAgent
						kind!: "VMAgent" | "VMAlert" | "VMSingle" | "VLogs" | "VMAlertManager" | "VMAlertmanager" | "VMCluster/vmselect" | "VMCluster/vmstorage" | "VMCluster/vminsert" | "VLSingle" | "VLCluster/vlinsert" | "VLCluster/vlselect" | "VLCluster/vlstorage" | "VLAgent" | "VTCluster/vtinsert" | "VTCluster/vtselect" | "VTCluster/vtstorage" | "VTSingle" | "VMAnomaly"

						// Name of the target Kubernetes object
						name!: string

						// Namespace of the target Kubernetes object
						namespace!: string

						// Objects defines list of name/namespace pairs that define existing k8s object
						objects?: [...{
							// Name of the target Kubernetes object
							name!: string

							// Namespace of the target Kubernetes object
							namespace!: string

							// UseExtraService instructs the operator to prefer the CR's additional service
							// (created via spec.serviceSpec) over the default service when building the target URL.
							useExtraService?: bool
						}]

						// UseExtraService instructs the operator to prefer the CR's additional service
						// (created via spec.serviceSpec) over the default service when building the target URL.
						useExtraService?: bool
					}

					// DiscoverBackendIPs instructs discovering URLPrefix backend IPs via DNS.
					discover_backend_ips?: bool

					// DropSrcPathPrefixParts is the number of `/`-delimited request path prefix
					// parts to drop before proxying the request to backend.
					// See
					// [here](https://docs.victoriametrics.com/victoriametrics/vmauth/#dropping-request-path-prefix)
					// for more details.
					drop_src_path_prefix_parts?: int

					// RequestHeaders represent additional http headers, that vmauth uses
					// in form of ["header_key: header_value"]
					// multiple values for header key:
					// ["header_key: value1,value2"]
					// it's available since 1.68.0 version of vmauth
					headers?: [...string]
					hosts?: [...string]

					// LoadBalancingPolicy defines load balancing policy to use for backend urls.
					// Supported policies: least_loaded, first_available.
					// See
					// [here](https://docs.victoriametrics.com/victoriametrics/vmauth/#load-balancing)
					// for more details (default "least_loaded")
					load_balancing_policy?: "least_loaded" | "first_available"

					// Name references item at VMAuths spec.defaultTargetRefs map, with name set
					// other attributes are skipped
					name?: string

					// Paths - matched path to route.
					paths?: [...string]

					// QueryArgs appends list of query arguments to generated URL
					query_args?: [...{
						// Name of query argument
						name!: string

						// Values of query argument
						values!: [...string]
					}]

					// ResponseHeaders represent additional http headers, that vmauth adds for request response
					// in form of ["header_key: header_value"]
					// multiple values for header key:
					// ["header_key: value1,value2"]
					// it's available since 1.93.0 version of vmauth
					response_headers?: [...string]

					// RetryStatusCodes defines http status codes in numeric format for request retries
					// Can be defined per target or at VMUser.spec level
					// e.g. [429,503]
					retry_status_codes?: [...int]

					// SrcHeaders is an optional list of headers, which must match request headers.
					src_headers?: [...string]

					// SrcQueryArgs is an optional list of query args, which must match request URL query args.
					src_query_args?: [...string]

					// Static - user defined url for traffic forward,
					// for instance http://vmsingle:8428
					static?: {
						// URL http url for given staticRef.
						url?: string

						// URLs allows setting multiple urls for load-balancing at vmauth-side.
						urls?: [...string]
					}

					// TargetPathSuffix allows to add some suffix to the target path
					// It allows to hide tenant configuration from user with crd as ref.
					// it also may contain any url encoded params.
					target_path_suffix?: string

					// TargetRefBasicAuth allow an target endpoint to authenticate over basic authentication
					targetRefBasicAuth?: {
						// The secret in the service scrape namespace that contains the password
						// for authentication.
						// It must be at them same namespace as CRD
						password!: {
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

						// The secret in the service scrape namespace that contains the username
						// for authentication.
						// It must be at them same namespace as CRD
						username!: {
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

				// EnableServiceLinks indicates whether information about services should be injected into pod's
				// environment variables, matching the syntax of Docker links.
				// Optional: Defaults to true.
				enableServiceLinks?: bool

				// ExternalConfig defines a source of external VMAuth configuration.
				// If it's defined, configuration for vmauth becomes unmanaged and operator'll
				// not create any related secrets/config-reloaders
				externalConfig?: {
					// LocalPath contains static path to a config, which is managed externally for cases
					// when using secrets is not applicable, e.g.: Vault sidecar.
					localPath?: string

					// SecretRef defines selector for externally managed secret which contains configuration
					secretRef?: {
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

				// Configures horizontal pod autoscaling.
				hpa?: {
					// HorizontalPodAutoscalerBehavior configures the scaling behavior of the target
					// in both Up and Down directions (scaleUp and scaleDown fields respectively).
					behaviour?: {
						// scaleDown is scaling policy for scaling Down.
						// If not set, the default value is to allow to scale down to minReplicas pods, with a
						// 300 second stabilization window (i.e., the highest recommendation for
						// the last 300sec is used).
						scaleDown?: {
							// policies is a list of potential scaling polices which can be used during scaling.
							// If not set, use the default values:
							// - For scale up: allow doubling the number of pods, or an absolute change of 4
							// pods in a 15s window.
							// - For scale down: allow all pods to be removed in a 15s window.
							policies?: [...{
								// periodSeconds specifies the window of time for which the policy should hold true.
								// PeriodSeconds must be greater than zero and less than or equal to 1800 (30 min).
								periodSeconds!: int32 & int

								// type is used to specify the scaling policy.
								type!: string

								// value contains the amount of change which is permitted by the policy.
								// It must be greater than zero
								value!: int32 & int
							}]

							// selectPolicy is used to specify which policy should be used.
							// If not set, the default value Max is used.
							selectPolicy?: string

							// stabilizationWindowSeconds is the number of seconds for which past recommendations should be
							// considered while scaling up or scaling down.
							// StabilizationWindowSeconds must be greater than or equal to zero and less
							// than or equal to 3600 (one hour).
							// If not set, use the default values:
							// - For scale up: 0 (i.e. no stabilization is done).
							// - For scale down: 300 (i.e. the stabilization window is 300 seconds long).
							stabilizationWindowSeconds?: int32 & int

							// tolerance is the tolerance on the ratio between the current and desired
							// metric value under which no updates are made to the desired number of
							// replicas (e.g. 0.01 for 1%). Must be greater than or equal to zero. If not
							// set, the default cluster-wide tolerance is applied (by default 10%).
							//
							// For example, if autoscaling is configured with a memory consumption target of 100Mi,
							// and scale-down and scale-up tolerances of 5% and 1% respectively, scaling will be
							// triggered when the actual consumption falls below 95Mi or exceeds 101Mi.
							tolerance?: matchN(>=1, [int, string]) & (int | =~"^(\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))(([KMGTPE]i)|[numkMGTPE]|([eE](\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))))?$")
						}

						// scaleUp is scaling policy for scaling Up.
						// If not set, the default value is the higher of:
						// * increase no more than 4 pods per 60 seconds
						// * double the number of pods per 60 seconds
						// No stabilization is used.
						scaleUp?: {
							// policies is a list of potential scaling polices which can be used during scaling.
							// If not set, use the default values:
							// - For scale up: allow doubling the number of pods, or an absolute change of 4
							// pods in a 15s window.
							// - For scale down: allow all pods to be removed in a 15s window.
							policies?: [...{
								// periodSeconds specifies the window of time for which the policy should hold true.
								// PeriodSeconds must be greater than zero and less than or equal to 1800 (30 min).
								periodSeconds!: int32 & int

								// type is used to specify the scaling policy.
								type!: string

								// value contains the amount of change which is permitted by the policy.
								// It must be greater than zero
								value!: int32 & int
							}]

							// selectPolicy is used to specify which policy should be used.
							// If not set, the default value Max is used.
							selectPolicy?: string

							// stabilizationWindowSeconds is the number of seconds for which past recommendations should be
							// considered while scaling up or scaling down.
							// StabilizationWindowSeconds must be greater than or equal to zero and less
							// than or equal to 3600 (one hour).
							// If not set, use the default values:
							// - For scale up: 0 (i.e. no stabilization is done).
							// - For scale down: 300 (i.e. the stabilization window is 300 seconds long).
							stabilizationWindowSeconds?: int32 & int

							// tolerance is the tolerance on the ratio between the current and desired
							// metric value under which no updates are made to the desired number of
							// replicas (e.g. 0.01 for 1%). Must be greater than or equal to zero. If not
							// set, the default cluster-wide tolerance is applied (by default 10%).
							//
							// For example, if autoscaling is configured with a memory consumption target of 100Mi,
							// and scale-down and scale-up tolerances of 5% and 1% respectively, scaling will be
							// triggered when the actual consumption falls below 95Mi or exceeds 101Mi.
							tolerance?: matchN(>=1, [int, string]) & (int | =~"^(\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))(([KMGTPE]i)|[numkMGTPE]|([eE](\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))))?$")
						}
					}
					maxReplicas?: int32 & int
					metrics?: [...{
						// containerResource refers to a resource metric (such as those specified in
						// requests and limits) known to Kubernetes describing a single container in
						// each pod of the current scale target (e.g. CPU or memory). Such metrics are
						// built in to Kubernetes, and have special scaling options on top of those
						// available to normal per-pod metrics using the "pods" source.
						containerResource?: {
							// container is the name of the container in the pods of the scaling target
							container!: string

							// name is the name of the resource in question.
							name!: string

							// target specifies the target value for the given metric
							target!: {
								// averageUtilization is the target value of the average of the
								// resource metric across all relevant pods, represented as a percentage of
								// the requested value of the resource for the pods.
								// Currently only valid for Resource metric source type
								averageUtilization?: int32 & int

								// averageValue is the target value of the average of the
								// metric across all relevant pods (as a quantity)
								averageValue?: matchN(>=1, [int, string]) & (int | =~"^(\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))(([KMGTPE]i)|[numkMGTPE]|([eE](\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))))?$")

								// type represents whether the metric type is Utilization, Value, or AverageValue
								type!: string

								// value is the target value of the metric (as a quantity).
								value?: matchN(>=1, [int, string]) & (int | =~"^(\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))(([KMGTPE]i)|[numkMGTPE]|([eE](\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))))?$")
							}
						}

						// external refers to a global metric that is not associated
						// with any Kubernetes object. It allows autoscaling based on information
						// coming from components running outside of cluster
						// (for example length of queue in cloud messaging service, or
						// QPS from loadbalancer running outside of cluster).
						external?: {
							// metric identifies the target metric by name and selector
							metric!: {
								// name is the name of the given metric
								name!: string

								// selector is the string-encoded form of a standard kubernetes label selector for the given metric
								// When set, it is passed as an additional parameter to the metrics server for
								// more specific metrics scoping.
								// When unset, just the metricName will be used to gather metrics.
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
							}

							// target specifies the target value for the given metric
							target!: {
								// averageUtilization is the target value of the average of the
								// resource metric across all relevant pods, represented as a percentage of
								// the requested value of the resource for the pods.
								// Currently only valid for Resource metric source type
								averageUtilization?: int32 & int

								// averageValue is the target value of the average of the
								// metric across all relevant pods (as a quantity)
								averageValue?: matchN(>=1, [int, string]) & (int | =~"^(\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))(([KMGTPE]i)|[numkMGTPE]|([eE](\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))))?$")

								// type represents whether the metric type is Utilization, Value, or AverageValue
								type!: string

								// value is the target value of the metric (as a quantity).
								value?: matchN(>=1, [int, string]) & (int | =~"^(\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))(([KMGTPE]i)|[numkMGTPE]|([eE](\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))))?$")
							}
						}

						// object refers to a metric describing a single kubernetes object
						// (for example, hits-per-second on an Ingress object).
						object?: {
							// describedObject specifies the descriptions of a object,such as kind,name apiVersion
							describedObject!: {
								// apiVersion is the API version of the referent
								apiVersion?: string

								// kind is the kind of the referent; More info:
								// https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#types-kinds
								kind!: string

								// name is the name of the referent; More info:
								// https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names
								name!: string
							}

							// metric identifies the target metric by name and selector
							metric!: {
								// name is the name of the given metric
								name!: string

								// selector is the string-encoded form of a standard kubernetes label selector for the given metric
								// When set, it is passed as an additional parameter to the metrics server for
								// more specific metrics scoping.
								// When unset, just the metricName will be used to gather metrics.
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
							}

							// target specifies the target value for the given metric
							target!: {
								// averageUtilization is the target value of the average of the
								// resource metric across all relevant pods, represented as a percentage of
								// the requested value of the resource for the pods.
								// Currently only valid for Resource metric source type
								averageUtilization?: int32 & int

								// averageValue is the target value of the average of the
								// metric across all relevant pods (as a quantity)
								averageValue?: matchN(>=1, [int, string]) & (int | =~"^(\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))(([KMGTPE]i)|[numkMGTPE]|([eE](\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))))?$")

								// type represents whether the metric type is Utilization, Value, or AverageValue
								type!: string

								// value is the target value of the metric (as a quantity).
								value?: matchN(>=1, [int, string]) & (int | =~"^(\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))(([KMGTPE]i)|[numkMGTPE]|([eE](\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))))?$")
							}
						}

						// pods refers to a metric describing each pod in the current scale target
						// (for example, transactions-processed-per-second). The values will be
						// averaged together before being compared to the target value.
						pods?: {
							// metric identifies the target metric by name and selector
							metric!: {
								// name is the name of the given metric
								name!: string

								// selector is the string-encoded form of a standard kubernetes label selector for the given metric
								// When set, it is passed as an additional parameter to the metrics server for
								// more specific metrics scoping.
								// When unset, just the metricName will be used to gather metrics.
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
							}

							// target specifies the target value for the given metric
							target!: {
								// averageUtilization is the target value of the average of the
								// resource metric across all relevant pods, represented as a percentage of
								// the requested value of the resource for the pods.
								// Currently only valid for Resource metric source type
								averageUtilization?: int32 & int

								// averageValue is the target value of the average of the
								// metric across all relevant pods (as a quantity)
								averageValue?: matchN(>=1, [int, string]) & (int | =~"^(\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))(([KMGTPE]i)|[numkMGTPE]|([eE](\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))))?$")

								// type represents whether the metric type is Utilization, Value, or AverageValue
								type!: string

								// value is the target value of the metric (as a quantity).
								value?: matchN(>=1, [int, string]) & (int | =~"^(\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))(([KMGTPE]i)|[numkMGTPE]|([eE](\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))))?$")
							}
						}

						// resource refers to a resource metric (such as those specified in
						// requests and limits) known to Kubernetes describing each pod in the
						// current scale target (e.g. CPU or memory). Such metrics are built in to
						// Kubernetes, and have special scaling options on top of those available
						// to normal per-pod metrics using the "pods" source.
						resource?: {
							// name is the name of the resource in question.
							name!: string

							// target specifies the target value for the given metric
							target!: {
								// averageUtilization is the target value of the average of the
								// resource metric across all relevant pods, represented as a percentage of
								// the requested value of the resource for the pods.
								// Currently only valid for Resource metric source type
								averageUtilization?: int32 & int

								// averageValue is the target value of the average of the
								// metric across all relevant pods (as a quantity)
								averageValue?: matchN(>=1, [int, string]) & (int | =~"^(\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))(([KMGTPE]i)|[numkMGTPE]|([eE](\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))))?$")

								// type represents whether the metric type is Utilization, Value, or AverageValue
								type!: string

								// value is the target value of the metric (as a quantity).
								value?: matchN(>=1, [int, string]) & (int | =~"^(\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))(([KMGTPE]i)|[numkMGTPE]|([eE](\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))))?$")
							}
						}

						// type is the type of metric source. It should be one of "ContainerResource", "External",
						// "Object", "Pods" or "Resource", each mapping to a matching field in the object.
						type!: string
					}]
					minReplicas?: int32 & int
				}

				// HTTPRoute enables httproute configuration for VMAuth.
				httpRoute?: {
					// Annotations is an unstructured key value map stored with a resource that may be
					// set by external tools to store and retrieve arbitrary metadata. They are not
					// queryable and should be preserved when modifying objects.
					// More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/annotations
					annotations?: [string]: string

					// ExtraRules defines custom HTTPRouteRule in raw form, bypassing Gateway API CEL validations.
					extraRules?: [...{
						...
					}]

					// Hostnames defines a set of hostnames that should match against the HTTP Host
					// header to select a HTTPRoute used to process the request.
					hostnames?: [...strings.MaxRunes(
						253) & strings.MinRunes(
						1) & =~"^(\\*\\.)?[a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*$"]

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

					// ParentRefs references the resources (usually Gateways) that a Route wants to be attached to.
					parentRefs?: [...{
						// Group is the group of the referent.
						// When unspecified, "gateway.networking.k8s.io" is inferred.
						// To set the core API group (such as for a "Service" kind referent),
						// Group must be explicitly set to "" (empty string).
						//
						// Support: Core
						group?: strings.MaxRunes(
							253) & =~"^$|^[a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*$"

						// Kind is kind of the referent.
						//
						// There are two kinds of parent resources with "Core" support:
						//
						// * Gateway (Gateway conformance profile)
						// * Service (Mesh conformance profile, ClusterIP Services only)
						//
						// Support for other resources is Implementation-Specific.
						kind?: strings.MaxRunes(
							63) & strings.MinRunes(
							1) & =~"^[a-zA-Z]([-a-zA-Z0-9]*[a-zA-Z0-9])?$"

						// Name is the name of the referent.
						//
						// Support: Core
						name!: strings.MaxRunes(
							253) & strings.MinRunes(
							1)

						// Namespace is the namespace of the referent. When unspecified, this refers
						// to the local namespace of the Route.
						//
						// Note that there are specific rules for ParentRefs which cross namespace
						// boundaries. Cross-namespace references are only valid if they are explicitly
						// allowed by something in the namespace they are referring to. For example:
						// Gateway has the AllowedRoutes field, and ReferenceGrant provides a
						// generic way to enable any other kind of cross-namespace reference.
						//
						// <gateway:experimental:description>
						// ParentRefs from a Route to a Service in the same namespace are "producer"
						// routes, which apply default routing rules to inbound connections from
						// any namespace to the Service.
						//
						// ParentRefs from a Route to a Service in a different namespace are
						// "consumer" routes, and these routing rules are only applied to outbound
						// connections originating from the same namespace as the Route, for which
						// the intended destination of the connections are a Service targeted as a
						// ParentRef of the Route.
						// </gateway:experimental:description>
						//
						// Support: Core
						namespace?: strings.MaxRunes(
								63) & strings.MinRunes(
								1) & =~"^[a-z0-9]([-a-z0-9]*[a-z0-9])?$"

						// Port is the network port this Route targets. It can be interpreted
						// differently based on the type of parent resource.
						//
						// When the parent resource is a Gateway, this targets all listeners
						// listening on the specified port that also support this kind of Route(and
						// select this Route). It's not recommended to set `Port` unless the
						// networking behaviors specified in a Route must apply to a specific port
						// as opposed to a listener(s) whose port(s) may be changed. When both Port
						// and SectionName are specified, the name and port of the selected listener
						// must match both specified values.
						//
						// <gateway:experimental:description>
						// When the parent resource is a Service, this targets a specific port in the
						// Service spec. When both Port (experimental) and SectionName are specified,
						// the name and port of the selected port must match both specified values.
						// </gateway:experimental:description>
						//
						// Implementations MAY choose to support other parent resources.
						// Implementations supporting other types of parent resources MUST clearly
						// document how/if Port is interpreted.
						//
						// For the purpose of status, an attachment is considered successful as
						// long as the parent resource accepts it partially. For example, Gateway
						// listeners can restrict which Routes can attach to them by Route kind,
						// namespace, or hostname. If 1 of 2 Gateway listeners accept attachment
						// from the referencing Route, the Route MUST be considered successfully
						// attached. If no Gateway listeners accept attachment from this Route,
						// the Route MUST be considered detached from the Gateway.
						//
						// Support: Extended
						port?: int32 & int & <=65535 & >=1

						// SectionName is the name of a section within the target resource. In the
						// following resources, SectionName is interpreted as the following:
						//
						// * Gateway: Listener name. When both Port (experimental) and SectionName
						// are specified, the name and port of the selected listener must match
						// both specified values.
						// * Service: Port name. When both Port (experimental) and SectionName
						// are specified, the name and port of the selected listener must match
						// both specified values.
						//
						// Implementations MAY choose to support attaching Routes to other resources.
						// If that is the case, they MUST clearly document how SectionName is
						// interpreted.
						//
						// When unspecified (empty string), this will reference the entire resource.
						// For the purpose of status, an attachment is considered successful if at
						// least one section in the parent resource accepts it. For example, Gateway
						// listeners can restrict which Routes can attach to them by Route kind,
						// namespace, or hostname. If 1 of 2 Gateway listeners accept attachment from
						// the referencing Route, the Route MUST be considered successfully
						// attached. If no Gateway listeners accept attachment from this Route, the
						// Route MUST be considered detached from the Gateway.
						//
						// Support: Core
						sectionName?: strings.MaxRunes(
								253) & strings.MinRunes(
								1) & =~"^[a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*$"
					}]
				}

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

				// Ingress enables ingress configuration for VMAuth.
				ingress?: {
					// Annotations is an unstructured key value map stored with a resource that may be
					// set by external tools to store and retrieve arbitrary metadata. They are not
					// queryable and should be preserved when modifying objects.
					// More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/annotations
					annotations?: [string]: string

					// ClassName defines ingress class name for VMAuth
					class_name?: string

					// ExtraRules - additional rules for ingress,
					// must be checked for correctness by user.
					extraRules?: [...{
						// host is the fully qualified domain name of a network host, as defined by RFC 3986.
						// Note the following deviations from the "host" part of the
						// URI as defined in RFC 3986:
						// 1. IPs are not allowed. Currently an IngressRuleValue can only apply to
						// the IP in the Spec of the parent Ingress.
						// 2. The `:` delimiter is not respected because ports are not allowed.
						// Currently the port of an Ingress is implicitly :80 for http and
						// :443 for https.
						// Both these may change in the future.
						// Incoming requests are matched against the host before the
						// IngressRuleValue. If the host is unspecified, the Ingress routes all
						// traffic based on the specified IngressRuleValue.
						//
						// host can be "precise" which is a domain name without the terminating dot of
						// a network host (e.g. "foo.bar.com") or "wildcard", which is a domain name
						// prefixed with a single wildcard label (e.g. "*.foo.com").
						// The wildcard character '*' must appear by itself as the first DNS label and
						// matches only a single label. You cannot have a wildcard label by itself (e.g. Host == "*").
						// Requests will be matched against the Host field in the following way:
						// 1. If host is precise, the request matches this rule if the http host header is equal to Host.
						// 2. If host is a wildcard, then the request matches this rule if the http host header
						// is to equal to the suffix (removing the first label) of the wildcard rule.
						host?: string

						// http is a HTTP IngressRuleValue, which contains a list of http selectors
						http?: {
							// paths is a collection of paths that map requests to backends.
							paths!: [...{
								// backend defines the referenced service endpoint to which the traffic
								// will be forwarded to.
								backend!: {
									// resource is an ObjectRef to another Kubernetes resource in the namespace
									// of the Ingress object. If resource is specified, a service.Name and
									// service.Port must not be specified.
									// This is a mutually exclusive setting with "Service".
									resource?: {
										// APIGroup is the group for the resource being referenced.
										// If APIGroup is not specified, the specified Kind must be in the core API group.
										// For any other third-party types, APIGroup is required.
										apiGroup?: string

										// Kind is the type of resource being referenced
										kind!: string

										// Name is the name of resource being referenced
										name!: string
									}

									// service references a service as a backend.
									// This is a mutually exclusive setting with "Resource".
									service?: {
										// name is the referenced service. The service must exist in
										// the same namespace as the Ingress object.
										name!: string

										// port of the referenced service. A port name or port number
										// is required for a IngressServiceBackend.
										port?: {
											// name is the name of the port on the Service.
											// This is a mutually exclusive setting with "Number".
											name?: string

											// number is the numerical port number (e.g. 80) on the Service.
											// This is a mutually exclusive setting with "Name".
											number?: int32 & int
										}
									}
								}

								// path is matched against the path of an incoming request. Currently it can
								// contain characters disallowed from the conventional "path" part of a URL
								// as defined by RFC 3986. Paths must begin with a '/' and must be present
								// when using PathType with value "Exact" or "Prefix".
								path?: string

								// pathType determines the interpretation of the path matching. PathType can
								// be one of the following values:
								// * Exact: Matches the URL path exactly.
								// * Prefix: Matches based on a URL path prefix split by '/'. Matching is
								// done on a path element by element basis. A path element refers is the
								// list of labels in the path split by the '/' separator. A request is a
								// match for path p if every p is an element-wise prefix of p of the
								// request path. Note that if the last element of the path is a substring
								// of the last element in request path, it is not a match (e.g. /foo/bar
								// matches /foo/bar/baz, but does not match /foo/barbaz).
								// * ImplementationSpecific: Interpretation of the Path matching is up to
								// the IngressClass. Implementations can treat this as a separate PathType
								// or treat it identically to Prefix or Exact path types.
								// Implementations are required to support all path types.
								pathType!: string
							}]
						}
					}]

					// ExtraTLS - additional TLS configuration for ingress
					// must be checked for correctness by user.
					extraTls?: [...{
						// hosts is a list of hosts included in the TLS certificate. The values in
						// this list must match the name/s used in the tlsSecret. Defaults to the
						// wildcard host setting for the loadbalancer controller fulfilling this
						// Ingress, if left unspecified.
						hosts?: [...string]

						// secretName is the name of the secret used to terminate TLS traffic on
						// port 443. Field is left optional to allow TLS routing based on SNI
						// hostname alone. If the SNI host in a listener conflicts with the "Host"
						// header field used by an IngressRule, the SNI host is used for termination
						// and value of the "Host" header is used for routing.
						secretName?: string
					}]

					// Host defines ingress host parameter for default rule
					// It will be used, only if TlsHosts is empty
					host?: string

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

					// Paths defines ingress paths parameter for default rule
					paths?: [...string]

					// TlsHosts configures TLS access for ingress, tlsSecretName must be defined for it.
					tlsHosts?: [...string]

					// TlsSecretName defines secretname at the VMAuth namespace with cert and key
					// https://kubernetes.io/docs/concepts/services-networking/ingress/#tls
					tlsSecretName?: string
				}

				// InitContainers allows adding initContainers to the pod definition.
				// Any errors during the execution of an initContainer will lead to a restart of the Pod.
				// More info: https://kubernetes.io/docs/concepts/workloads/pods/init-containers/
				initContainers?: [...{
					name!: _
					...
				}]

				// InternalListenPort instructs vmauth to serve internal routes at given port
				// available from v1.111.0 vmauth version
				// related doc https://docs.victoriametrics.com/victoriametrics/vmauth/#security
				internalListenPort?: string

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

				// LogFormat for VMAuth to be configured with.
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

				// MinReadySeconds defines a minimum number of seconds to wait before starting update next pod
				// if previous in healthy state
				// Has no effect for VLogs and VMSingle
				minReadySeconds?: int32 & int

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

				// NodeSelector Define which Nodes the Pods are scheduled on.
				nodeSelector?: [string]: string

				// Paused If set to true all actions on the underlying managed objects are not
				// going to be performed, except for delete actions.
				paused?: bool

				// PodDisruptionBudget created by operator
				podDisruptionBudget?: {
					// An eviction is allowed if at most "maxUnavailable" pods selected by
					// "selector" are unavailable after the eviction, i.e. even in absence of
					// the evicted pod. For example, one can prevent all voluntary evictions
					// by specifying 0. This is a mutually exclusive setting with "minAvailable".
					maxUnavailable?: matchN(>=1, [int, string]) & (int | string)

					// An eviction is allowed if at least "minAvailable" pods selected by
					// "selector" will still be available after the eviction, i.e. even in the
					// absence of the evicted pod. So for example you can prevent all voluntary
					// evictions by specifying "100%".
					minAvailable?: matchN(>=1, [int, string]) & (int | string)

					// replaces default labels selector generated by operator
					// it's useful when you need to create custom budget
					selectorLabels?: [string]: string

					// UnhealthyPodEvictionPolicy defines the criteria for when unhealthy pods
					//
					// Valid policies are IfHealthyBudget and AlwaysAllow.
					// If no policy is specified, the default behavior will be used,
					// which corresponds to the IfHealthyBudget policy.
					unhealthyPodEvictionPolicy?: "IfHealthyBudget" | "AlwaysAllow"
				}

				// PodMetadata configures Labels and Annotations which are propagated to the VMAuth pods.
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

				// Port listen address
				port?: string

				// PreStopSleepSeconds defines the number of seconds to sleep in the preStop lifecycle hook.
				// It gives time for load balancers to remove the pod from rotation before the pod is terminated.
				// Defaults to 15 for applicable components. Set to 0 to disable.
				preStopSleepSeconds?: int32 & int

				// PriorityClassName class assigned to the Pods
				priorityClassName?: string

				// ReadinessGates defines pod readiness gates
				readinessGates?: [...{
					// ConditionType refers to a condition in the pod's condition list with matching type.
					conditionType!: string
				}]

				// ReadinessProbe that will be added to CR pod
				readinessProbe?: {
					...
				}

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

				// The number of old ReplicaSets to retain to allow rollback in deployment or
				// maximum number of revisions that will be maintained in the Deployment revision history.
				// Has no effect at StatefulSets
				// Defaults to 10.
				revisionHistoryLimitCount?: int32 & int

				// RollingUpdate - overrides deployment update params.
				rollingUpdate?: {
					// The maximum number of pods that can be scheduled above the desired number of
					// pods.
					// Value can be an absolute number (ex: 5) or a percentage of desired pods (ex: 10%).
					// This can not be 0 if MaxUnavailable is 0.
					// Absolute number is calculated from percentage by rounding up.
					// Defaults to 25%.
					// Example: when this is set to 30%, the new ReplicaSet can be scaled up immediately when
					// the rolling update starts, such that the total number of old and new pods do not exceed
					// 130% of desired pods. Once old pods have been killed,
					// new ReplicaSet can be scaled up further, ensuring that total number of pods running
					// at any time during the update is at most 130% of desired pods.
					maxSurge?: matchN(>=1, [int, string]) & (int | string)

					// The maximum number of pods that can be unavailable during the update.
					// Value can be an absolute number (ex: 5) or a percentage of desired pods (ex: 10%).
					// Absolute number is calculated from percentage by rounding down.
					// This can not be 0 if MaxSurge is 0.
					// Defaults to 25%.
					// Example: when this is set to 30%, the old ReplicaSet can be scaled down to 70% of desired pods
					// immediately when the rolling update starts. Once new pods are ready, old ReplicaSet
					// can be scaled down further, followed by scaling up the new ReplicaSet, ensuring
					// that the total number of pods available at all times during the update is at
					// least 70% of desired pods.
					maxUnavailable?: matchN(>=1, [int, string]) & (int | string)
				}

				// RuntimeClassName - defines runtime class for kubernetes pod.
				// https://kubernetes.io/docs/concepts/containers/runtime-class/
				runtimeClassName?: string

				// SchedulerName - defines kubernetes scheduler name
				schedulerName?: string

				// Secrets is a list of Secrets in the same namespace as the Application
				// object, which shall be mounted into the Application container
				// at /etc/vm/secrets/SECRET_NAME folder
				secrets?: [...string]

				// SecurityContext holds pod-level security attributes and common container settings.
				// This defaults to the default PodSecurityContext.
				securityContext?: {
					...
				}

				// SelectAllByDefault changes default behavior for empty CRD selectors, such userSelector.
				// with selectAllByDefault: true and empty userSelector and userNamespaceSelector
				// Operator selects all exist users
				// with selectAllByDefault: false - selects nothing
				selectAllByDefault?: bool

				// ServiceAccountName is the name of the ServiceAccount to use to run the pods
				serviceAccountName?: string

				// ServiceScrapeSpec that will be added to vmauth VMServiceScrape spec
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

				// UnauthorizedAccessConfig configures access for un authorized users
				unauthorizedAccessConfig?: null | bool | number | string | [...] | {
					...
				}

				// UnauthorizedUserAccessSpec defines unauthorized_user config section of vmauth config
				unauthorizedUserAccessSpec?: {
					// AccessLog configures per-user access logging.
					// When set, vmauth logs each request for this user with fields including
					// request_uri, status_code, duration_ms, username, etc.
					// See https://docs.victoriametrics.com/victoriametrics/vmauth/#access-log
					//
					// available since v1.138.0 vmauth version
					access_log?: {
						// Filters defines optional filters that control which requests are logged.
						filters?: {
							// SkipStatusCodes lists HTTP status codes whose responses are excluded from the access log.
							// For example, [200, 204] suppresses logging of successful responses.
							skip_status_codes?: [...int]
						}
					}

					// DefaultURLs backend url for non-matching paths filter
					// usually used for default backend with error message
					default_url?: [...string]

					// DiscoverBackendIPs instructs discovering URLPrefix backend IPs via DNS.
					discover_backend_ips?: bool

					// DropSrcPathPrefixParts is the number of `/`-delimited request path prefix
					// parts to drop before proxying the request to backend.
					// See
					// [here](https://docs.victoriametrics.com/victoriametrics/vmauth/#dropping-request-path-prefix)
					// for more details.
					drop_src_path_prefix_parts?: int

					// DumpRequestOnErrors instructs vmauth to return detailed request params to the client
					// if routing rules don't allow to forward request to the backends.
					// Useful for debugging `src_hosts` and `src_headers` based routing rules
					//
					// available since v1.107.0 vmauth version
					dump_request_on_errors?: bool

					// Headers represent additional http headers, that vmauth uses
					// in form of ["header_key: header_value"]
					// multiple values for header key:
					// ["header_key: value1,value2"]
					// it's available since 1.68.0 version of vmauth
					headers?: [...string]

					// IPFilters defines per target src ip filters
					// supported only with enterprise version of
					// [vmauth](https://docs.victoriametrics.com/victoriametrics/vmauth/#ip-filters)
					ip_filters?: {
						allow_list?: [...string]
						deny_list?: [...string]
					}

					// LoadBalancingPolicy defines load balancing policy to use for backend urls.
					// Supported policies: least_loaded, first_available.
					// See
					// [here](https://docs.victoriametrics.com/victoriametrics/vmauth/#load-balancing)
					// for more details (default "least_loaded")
					load_balancing_policy?: "least_loaded" | "first_available"

					// MaxConcurrentRequests defines max concurrent requests per user
					// 300 is default value for vmauth
					max_concurrent_requests?: int

					// MetricLabels - additional labels for metrics exported by vmauth for given user.
					metric_labels?: [string]: string

					// ResponseHeaders represent additional http headers, that vmauth adds for request response
					// in form of ["header_key: header_value"]
					// multiple values for header key:
					// ["header_key: value1,value2"]
					// it's available since 1.93.0 version of vmauth
					response_headers?: [...string]

					// RetryStatusCodes defines http status codes in numeric format for request retries
					// e.g. [429,503]
					retry_status_codes?: [...int]

					// TargetRefs - reference to endpoints, which user may access.
					targetRefs?: [...{
						// CRD describes exist operator's CRD object,
						// operator generates access url based on CRD params.
						crd?: {
							// Kind one of:
							// VMAgent,VMAlert, VMSingle, VMCluster/vmselect,
							// VMCluster/vmstorage,VMCluster/vminsert,VMAlertManager, VLSingle,
							// VLCluster/vlinsert, VLCluster/vlselect, VLCluster/vlstorage, VTSingle,
							// VTCluster/vtinsert, VTCluster/vtselect, VTCluster/vtstorage VMAnomaly and
							// VLAgent
							kind!: "VMAgent" | "VMAlert" | "VMSingle" | "VLogs" | "VMAlertManager" | "VMAlertmanager" | "VMCluster/vmselect" | "VMCluster/vmstorage" | "VMCluster/vminsert" | "VLSingle" | "VLCluster/vlinsert" | "VLCluster/vlselect" | "VLCluster/vlstorage" | "VLAgent" | "VTCluster/vtinsert" | "VTCluster/vtselect" | "VTCluster/vtstorage" | "VTSingle" | "VMAnomaly"

							// Name of the target Kubernetes object
							name!: string

							// Namespace of the target Kubernetes object
							namespace!: string

							// Objects defines list of name/namespace pairs that define existing k8s object
							objects?: [...{
								// Name of the target Kubernetes object
								name!: string

								// Namespace of the target Kubernetes object
								namespace!: string

								// UseExtraService instructs the operator to prefer the CR's additional service
								// (created via spec.serviceSpec) over the default service when building the target URL.
								useExtraService?: bool
							}]

							// UseExtraService instructs the operator to prefer the CR's additional service
							// (created via spec.serviceSpec) over the default service when building the target URL.
							useExtraService?: bool
						}

						// DiscoverBackendIPs instructs discovering URLPrefix backend IPs via DNS.
						discover_backend_ips?: bool

						// DropSrcPathPrefixParts is the number of `/`-delimited request path prefix
						// parts to drop before proxying the request to backend.
						// See
						// [here](https://docs.victoriametrics.com/victoriametrics/vmauth/#dropping-request-path-prefix)
						// for more details.
						drop_src_path_prefix_parts?: int

						// RequestHeaders represent additional http headers, that vmauth uses
						// in form of ["header_key: header_value"]
						// multiple values for header key:
						// ["header_key: value1,value2"]
						// it's available since 1.68.0 version of vmauth
						headers?: [...string]
						hosts?: [...string]

						// LoadBalancingPolicy defines load balancing policy to use for backend urls.
						// Supported policies: least_loaded, first_available.
						// See
						// [here](https://docs.victoriametrics.com/victoriametrics/vmauth/#load-balancing)
						// for more details (default "least_loaded")
						load_balancing_policy?: "least_loaded" | "first_available"

						// Name references item at VMAuths spec.defaultTargetRefs map, with name set
						// other attributes are skipped
						name?: string

						// Paths - matched path to route.
						paths?: [...string]

						// QueryArgs appends list of query arguments to generated URL
						query_args?: [...{
							// Name of query argument
							name!: string

							// Values of query argument
							values!: [...string]
						}]

						// ResponseHeaders represent additional http headers, that vmauth adds for request response
						// in form of ["header_key: header_value"]
						// multiple values for header key:
						// ["header_key: value1,value2"]
						// it's available since 1.93.0 version of vmauth
						response_headers?: [...string]

						// RetryStatusCodes defines http status codes in numeric format for request retries
						// Can be defined per target or at VMUser.spec level
						// e.g. [429,503]
						retry_status_codes?: [...int]

						// SrcHeaders is an optional list of headers, which must match request headers.
						src_headers?: [...string]

						// SrcQueryArgs is an optional list of query args, which must match request URL query args.
						src_query_args?: [...string]

						// Static - user defined url for traffic forward,
						// for instance http://vmsingle:8428
						static?: {
							// URL http url for given staticRef.
							url?: string

							// URLs allows setting multiple urls for load-balancing at vmauth-side.
							urls?: [...string]
						}

						// TargetPathSuffix allows to add some suffix to the target path
						// It allows to hide tenant configuration from user with crd as ref.
						// it also may contain any url encoded params.
						target_path_suffix?: string

						// TargetRefBasicAuth allow an target endpoint to authenticate over basic authentication
						targetRefBasicAuth?: {
							// The secret in the service scrape namespace that contains the password
							// for authentication.
							// It must be at them same namespace as CRD
							password!: {
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

							// The secret in the service scrape namespace that contains the username
							// for authentication.
							// It must be at them same namespace as CRD
							username!: {
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

					// TLSConfig defines tls configuration for the backend connection
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

					// URLMap defines url map for destination
					url_map?: [...{
						// DiscoverBackendIPs instructs discovering URLPrefix backend IPs via DNS.
						discover_backend_ips?: bool

						// DropSrcPathPrefixParts is the number of `/`-delimited request path prefix
						// parts to drop before proxying the request to backend.
						// See
						// [here](https://docs.victoriametrics.com/victoriametrics/vmauth/#dropping-request-path-prefix)
						// for more details.
						drop_src_path_prefix_parts?: int

						// RequestHeaders represent additional http headers, that vmauth uses
						// in form of ["header_key: header_value"]
						// multiple values for header key:
						// ["header_key: value1,value2"]
						// it's available since 1.68.0 version of vmauth
						headers?: [...string]

						// LoadBalancingPolicy defines load balancing policy to use for backend urls.
						// Supported policies: least_loaded, first_available.
						// See
						// [here](https://docs.victoriametrics.com/victoriametrics/vmauth/#load-balancing)
						// for more details (default "least_loaded")
						load_balancing_policy?: "least_loaded" | "first_available"

						// ResponseHeaders represent additional http headers, that vmauth adds for request response
						// in form of ["header_key: header_value"]
						// multiple values for header key:
						// ["header_key: value1,value2"]
						// it's available since 1.93.0 version of vmauth
						response_headers?: [...string]

						// RetryStatusCodes defines http status codes in numeric format for request retries
						// Can be defined per target or at VMUser.spec level
						// e.g. [429,503]
						retry_status_codes?: [...int]

						// SrcHeaders is an optional list of headers, which must match request headers.
						src_headers?: [...string]

						// SrcHosts is an optional list of regular expressions, which must match the request hostname.
						src_hosts?: [...string]

						// SrcPaths is an optional list of regular expressions, which must match the request path.
						src_paths?: [...string]

						// SrcQueryArgs is an optional list of query args, which must match request URL query args.
						src_query_args?: [...string]

						// UrlPrefix contains backend url prefixes for the proxied request url.
						// URLPrefix defines prefix prefix for destination
						url_prefix?: null | bool | number | string | [...] | {
							...
						}
					}]

					// URLPrefix defines url prefix for destination
					url_prefix?: null | bool | number | string | [...] | {
						...
					}
				}

				// UpdateStrategy - overrides default update strategy.
				updateStrategy?: "Recreate" | "RollingUpdate"

				// UseDefaultResources controls resource settings
				// By default, operator sets built-in resource requirements
				useDefaultResources?: bool

				// UseLegacyNaming uses standalone Helm chart naming for managed resources:
				// the CR name is used directly instead of the default "<type>-<name>" convention.
				useLegacyNaming?: bool

				// UseProxyProtocol enables proxy protocol for vmauth
				// https://www.haproxy.org/download/2.3/doc/proxy-protocol.txt
				useProxyProtocol?: bool

				// UseStrictSecurity enables strict security mode for component
				// it restricts disk writes access
				// uses non-root user out of the box
				// drops not needed security permissions
				useStrictSecurity?: bool

				// UseVMConfigReloader replaces prometheus-like config-reloader
				// with vm one. It uses secrets watch instead of file watch
				// which greatly increases speed of config updates
				useVMConfigReloader?: bool

				// UserNamespaceSelector Namespaces to be selected for VMAuth discovery.
				// Works in combination with Selector.
				// NamespaceSelector nil - only objects at VMAuth namespace.
				// Selector nil - only objects at NamespaceSelector namespaces.
				// If both nil - behaviour controlled by selectAllByDefault
				userNamespaceSelector?: {
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

				// UserSelector defines VMUser to be selected for config file generation.
				// Works in combination with NamespaceSelector.
				// NamespaceSelector nil - only objects at VMAuth namespace.
				// If both nil - behaviour controlled by selectAllByDefault
				userSelector?: {
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

				// WaitForConfigReload instructs the operator to verify, via the config-reloader
				// sidecar's own reload-confirmation metric, that every replica has actually reloaded
				// before marking dependent objects (e.g. VMUser) as applied.
				waitForConfigReload?: bool
				...
			}
		}

		// ZoneCommon defines common properties for all zones
		zoneCommon?: {
			// ReadyTimeout is the readiness timeout for each zone update.
			readyTimeout?: string

			// RemoteWrite defines VMAgent remote write settings for given zone
			remoteWrite?: null | bool | number | string | [...] | {
				...
			}

			// UpdatePause is the time the operator should wait between zone updates to
			// ensure a smooth transition.
			updatePause?: string

			// VMAgent defines VMAgent to balance incoming traffic between VMClusters.
			vmagent?: {
				// Name specifies the static name to be used for the VMAgent when Spec is provided.
				name?: string

				// Spec defines the desired state of a new VMAgent.
				spec?: {
					// Affinity If specified, the pod's scheduling constraints.
					affinity?: {
						...
					}

					// ClaimTemplates allows adding additional VolumeClaimTemplates for VMAgent in StatefulMode
					claimTemplates?: [...{
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

						// Standard object's metadata.
						// More info:
						// https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#metadata
						metadata?: {
							...
						}

						// spec defines the desired characteristics of a volume requested by a pod author.
						// More info: https://kubernetes.io/docs/concepts/storage/persistent-volumes#persistentvolumeclaims
						spec?: {
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

						// status represents the current information/status of a persistent volume claim.
						// Read-only.
						// More info: https://kubernetes.io/docs/concepts/storage/persistent-volumes#persistentvolumeclaims
						status?: {
							// accessModes contains the actual access modes the volume backing the PVC has.
							// More info: https://kubernetes.io/docs/concepts/storage/persistent-volumes#access-modes-1
							accessModes?: [...string]

							// allocatedResourceStatuses stores status of resource being resized for the given PVC.
							// Key names follow standard Kubernetes label syntax. Valid values are either:
							// * Un-prefixed keys:
							// - storage - the capacity of the volume.
							// * Custom resources must use implementation-defined prefixed names such as
							// "example.com/my-custom-resource"
							// Apart from above values - keys that are unprefixed or have kubernetes.io prefix are considered
							// reserved and hence may not be used.
							//
							// ClaimResourceStatus can be in any of following states:
							// - ControllerResizeInProgress:
							// State set when resize controller starts resizing the volume in control-plane.
							// - ControllerResizeFailed:
							// State set when resize has failed in resize controller with a terminal error.
							// - NodeResizePending:
							// State set when resize controller has finished resizing the volume but further resizing of
							// volume is needed on the node.
							// - NodeResizeInProgress:
							// State set when kubelet starts resizing the volume.
							// - NodeResizeFailed:
							// State set when resizing has failed in kubelet with a terminal error. Transient errors don't set
							// NodeResizeFailed.
							// For example: if expanding a PVC for more capacity - this field can be one of
							// the following states:
							// - pvc.status.allocatedResourceStatus['storage'] = "ControllerResizeInProgress"
							// - pvc.status.allocatedResourceStatus['storage'] = "ControllerResizeFailed"
							// - pvc.status.allocatedResourceStatus['storage'] = "NodeResizePending"
							// - pvc.status.allocatedResourceStatus['storage'] = "NodeResizeInProgress"
							// - pvc.status.allocatedResourceStatus['storage'] = "NodeResizeFailed"
							// When this field is not set, it means that no resize operation is in progress for the given PVC.
							//
							// A controller that receives PVC update with previously unknown resourceName or ClaimResourceStatus
							// should ignore the update for the purpose it was designed. For example - a controller that
							// only is responsible for resizing capacity of the volume, should ignore PVC
							// updates that change other valid
							// resources associated with PVC.
							allocatedResourceStatuses?: [string]: string

							// allocatedResources tracks the resources allocated to a PVC including its capacity.
							// Key names follow standard Kubernetes label syntax. Valid values are either:
							// * Un-prefixed keys:
							// - storage - the capacity of the volume.
							// * Custom resources must use implementation-defined prefixed names such as
							// "example.com/my-custom-resource"
							// Apart from above values - keys that are unprefixed or have kubernetes.io prefix are considered
							// reserved and hence may not be used.
							//
							// Capacity reported here may be larger than the actual capacity when a volume expansion operation
							// is requested.
							// For storage quota, the larger value from allocatedResources and PVC.spec.resources is used.
							// If allocatedResources is not set, PVC.spec.resources alone is used for quota calculation.
							// If a volume expansion capacity request is lowered, allocatedResources is only
							// lowered if there are no expansion operations in progress and if the actual volume capacity
							// is equal or lower than the requested capacity.
							//
							// A controller that receives PVC update with previously unknown resourceName
							// should ignore the update for the purpose it was designed. For example - a controller that
							// only is responsible for resizing capacity of the volume, should ignore PVC
							// updates that change other valid
							// resources associated with PVC.
							allocatedResources?: [string]: matchN(>=1, [int, string]) & (int | =~"^(\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))(([KMGTPE]i)|[numkMGTPE]|([eE](\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))))?$")

							// capacity represents the actual resources of the underlying volume.
							capacity?: [string]: matchN(>=1, [int, string]) & (int | =~"^(\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))(([KMGTPE]i)|[numkMGTPE]|([eE](\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))))?$")

							// conditions is the current Condition of persistent volume claim. If underlying
							// persistent volume is being
							// resized then the Condition will be set to 'Resizing'.
							conditions?: [...{
								// lastProbeTime is the time we probed the condition.
								lastProbeTime?: time.Time

								// lastTransitionTime is the time the condition transitioned from one status to another.
								lastTransitionTime?: time.Time

								// message is the human-readable message indicating details about last transition.
								message?: string

								// reason is a unique, this should be a short, machine understandable string that gives the reason
								// for condition's last transition. If it reports "Resizing" that means the underlying
								// persistent volume is being resized.
								reason?: string

								// Status is the status of the condition.
								// Can be True, False, Unknown.
								// More info:
								// https://kubernetes.io/docs/reference/kubernetes-api/config-and-storage-resources/persistent-volume-claim-v1/#:~:text=state%20of%20pvc-,conditions.status,-(string)%2C%20required
								status!: string

								// Type is the type of the condition.
								// More info:
								// https://kubernetes.io/docs/reference/kubernetes-api/config-and-storage-resources/persistent-volume-claim-v1/#:~:text=set%20to%20%27ResizeStarted%27.-,PersistentVolumeClaimCondition,-contains%20details%20about
								type!: string
							}]

							// currentVolumeAttributesClassName is the current name of the
							// VolumeAttributesClass the PVC is using.
							// When unset, there is no VolumeAttributeClass applied to this PersistentVolumeClaim
							currentVolumeAttributesClassName?: string

							// healthStatus contains the latest controller-reported health information
							// for the volume bound to this claim.
							healthStatus?: {
								// conditions is the set of adverse conditions reported by
								// the CSI controller plugin. An empty list means no adverse condition.
								// At most 16 conditions may be reported.
								healthConditions?: [...{
									// message is a human-readable description.
									// Maximum permitted length of a message is 1024 bytes.
									message?: string

									// reason is a brief CamelCase machine-parseable reason.
									// Together with status it forms the unique identity of a condition entry.
									// Maximum permitted length of a reason is 256 bytes.
									reason!: string

									// status is the machine-parseable health category.
									// Possible values:
									// - "Inaccessible": the volume cannot be accessed.
									// - "DataLoss": data loss has been detected on the volume.
									// - "Degraded": the volume is functioning with reduced capability.
									status!: "DataLoss" | "Degraded" | "Inaccessible"
								}]

								// lastTransitionTime is when the current set of conditions first appeared.
								lastTransitionTime?: time.Time
							}

							// ModifyVolumeStatus represents the status object of ControllerModifyVolume operation.
							// When this is unset, there is no ModifyVolume operation being attempted.
							modifyVolumeStatus?: {
								// status is the status of the ControllerModifyVolume operation. It can be in
								// any of following states:
								// - Pending
								// Pending indicates that the PersistentVolumeClaim cannot be modified due to
								// unmet requirements, such as
								// the specified VolumeAttributesClass not existing.
								// - InProgress
								// InProgress indicates that the volume is being modified.
								// - Infeasible
								// Infeasible indicates that the request has been rejected as invalid by the CSI driver. To
								// resolve the error, a valid VolumeAttributesClass needs to be specified.
								// Note: New statuses can be added in the future. Consumers should check for
								// unknown statuses and fail appropriately.
								status!: string

								// targetVolumeAttributesClassName is the name of the VolumeAttributesClass the
								// PVC currently being reconciled
								targetVolumeAttributesClassName?: string
							}

							// phase represents the current phase of PersistentVolumeClaim.
							phase?: string
						}
					}]

					// ConfigMaps is a list of ConfigMaps in the same namespace as the Application
					// object, which shall be mounted into the Application container
					// at /etc/vm/configs/CONFIGMAP_NAME folder
					configMaps?: [...string]

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

					// EnableServiceLinks indicates whether information about services should be injected into pod's
					// environment variables, matching the syntax of Docker links.
					// Optional: Defaults to true.
					enableServiceLinks?: bool

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

					// Configures horizontal pod autoscaling.
					hpa?: {
						// HorizontalPodAutoscalerBehavior configures the scaling behavior of the target
						// in both Up and Down directions (scaleUp and scaleDown fields respectively).
						behaviour?: {
							// scaleDown is scaling policy for scaling Down.
							// If not set, the default value is to allow to scale down to minReplicas pods, with a
							// 300 second stabilization window (i.e., the highest recommendation for
							// the last 300sec is used).
							scaleDown?: {
								// policies is a list of potential scaling polices which can be used during scaling.
								// If not set, use the default values:
								// - For scale up: allow doubling the number of pods, or an absolute change of 4
								// pods in a 15s window.
								// - For scale down: allow all pods to be removed in a 15s window.
								policies?: [...{
									// periodSeconds specifies the window of time for which the policy should hold true.
									// PeriodSeconds must be greater than zero and less than or equal to 1800 (30 min).
									periodSeconds!: int32 & int

									// type is used to specify the scaling policy.
									type!: string

									// value contains the amount of change which is permitted by the policy.
									// It must be greater than zero
									value!: int32 & int
								}]

								// selectPolicy is used to specify which policy should be used.
								// If not set, the default value Max is used.
								selectPolicy?: string

								// stabilizationWindowSeconds is the number of seconds for which past recommendations should be
								// considered while scaling up or scaling down.
								// StabilizationWindowSeconds must be greater than or equal to zero and less
								// than or equal to 3600 (one hour).
								// If not set, use the default values:
								// - For scale up: 0 (i.e. no stabilization is done).
								// - For scale down: 300 (i.e. the stabilization window is 300 seconds long).
								stabilizationWindowSeconds?: int32 & int

								// tolerance is the tolerance on the ratio between the current and desired
								// metric value under which no updates are made to the desired number of
								// replicas (e.g. 0.01 for 1%). Must be greater than or equal to zero. If not
								// set, the default cluster-wide tolerance is applied (by default 10%).
								//
								// For example, if autoscaling is configured with a memory consumption target of 100Mi,
								// and scale-down and scale-up tolerances of 5% and 1% respectively, scaling will be
								// triggered when the actual consumption falls below 95Mi or exceeds 101Mi.
								tolerance?: matchN(>=1, [int, string]) & (int | =~"^(\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))(([KMGTPE]i)|[numkMGTPE]|([eE](\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))))?$")
							}

							// scaleUp is scaling policy for scaling Up.
							// If not set, the default value is the higher of:
							// * increase no more than 4 pods per 60 seconds
							// * double the number of pods per 60 seconds
							// No stabilization is used.
							scaleUp?: {
								// policies is a list of potential scaling polices which can be used during scaling.
								// If not set, use the default values:
								// - For scale up: allow doubling the number of pods, or an absolute change of 4
								// pods in a 15s window.
								// - For scale down: allow all pods to be removed in a 15s window.
								policies?: [...{
									// periodSeconds specifies the window of time for which the policy should hold true.
									// PeriodSeconds must be greater than zero and less than or equal to 1800 (30 min).
									periodSeconds!: int32 & int

									// type is used to specify the scaling policy.
									type!: string

									// value contains the amount of change which is permitted by the policy.
									// It must be greater than zero
									value!: int32 & int
								}]

								// selectPolicy is used to specify which policy should be used.
								// If not set, the default value Max is used.
								selectPolicy?: string

								// stabilizationWindowSeconds is the number of seconds for which past recommendations should be
								// considered while scaling up or scaling down.
								// StabilizationWindowSeconds must be greater than or equal to zero and less
								// than or equal to 3600 (one hour).
								// If not set, use the default values:
								// - For scale up: 0 (i.e. no stabilization is done).
								// - For scale down: 300 (i.e. the stabilization window is 300 seconds long).
								stabilizationWindowSeconds?: int32 & int

								// tolerance is the tolerance on the ratio between the current and desired
								// metric value under which no updates are made to the desired number of
								// replicas (e.g. 0.01 for 1%). Must be greater than or equal to zero. If not
								// set, the default cluster-wide tolerance is applied (by default 10%).
								//
								// For example, if autoscaling is configured with a memory consumption target of 100Mi,
								// and scale-down and scale-up tolerances of 5% and 1% respectively, scaling will be
								// triggered when the actual consumption falls below 95Mi or exceeds 101Mi.
								tolerance?: matchN(>=1, [int, string]) & (int | =~"^(\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))(([KMGTPE]i)|[numkMGTPE]|([eE](\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))))?$")
							}
						}
						maxReplicas?: int32 & int
						metrics?: [...{
							// containerResource refers to a resource metric (such as those specified in
							// requests and limits) known to Kubernetes describing a single container in
							// each pod of the current scale target (e.g. CPU or memory). Such metrics are
							// built in to Kubernetes, and have special scaling options on top of those
							// available to normal per-pod metrics using the "pods" source.
							containerResource?: {
								// container is the name of the container in the pods of the scaling target
								container!: string

								// name is the name of the resource in question.
								name!: string

								// target specifies the target value for the given metric
								target!: {
									// averageUtilization is the target value of the average of the
									// resource metric across all relevant pods, represented as a percentage of
									// the requested value of the resource for the pods.
									// Currently only valid for Resource metric source type
									averageUtilization?: int32 & int

									// averageValue is the target value of the average of the
									// metric across all relevant pods (as a quantity)
									averageValue?: matchN(>=1, [int, string]) & (int | =~"^(\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))(([KMGTPE]i)|[numkMGTPE]|([eE](\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))))?$")

									// type represents whether the metric type is Utilization, Value, or AverageValue
									type!: string

									// value is the target value of the metric (as a quantity).
									value?: matchN(>=1, [int, string]) & (int | =~"^(\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))(([KMGTPE]i)|[numkMGTPE]|([eE](\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))))?$")
								}
							}

							// external refers to a global metric that is not associated
							// with any Kubernetes object. It allows autoscaling based on information
							// coming from components running outside of cluster
							// (for example length of queue in cloud messaging service, or
							// QPS from loadbalancer running outside of cluster).
							external?: {
								// metric identifies the target metric by name and selector
								metric!: {
									// name is the name of the given metric
									name!: string

									// selector is the string-encoded form of a standard kubernetes label selector for the given metric
									// When set, it is passed as an additional parameter to the metrics server for
									// more specific metrics scoping.
									// When unset, just the metricName will be used to gather metrics.
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
								}

								// target specifies the target value for the given metric
								target!: {
									// averageUtilization is the target value of the average of the
									// resource metric across all relevant pods, represented as a percentage of
									// the requested value of the resource for the pods.
									// Currently only valid for Resource metric source type
									averageUtilization?: int32 & int

									// averageValue is the target value of the average of the
									// metric across all relevant pods (as a quantity)
									averageValue?: matchN(>=1, [int, string]) & (int | =~"^(\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))(([KMGTPE]i)|[numkMGTPE]|([eE](\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))))?$")

									// type represents whether the metric type is Utilization, Value, or AverageValue
									type!: string

									// value is the target value of the metric (as a quantity).
									value?: matchN(>=1, [int, string]) & (int | =~"^(\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))(([KMGTPE]i)|[numkMGTPE]|([eE](\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))))?$")
								}
							}

							// object refers to a metric describing a single kubernetes object
							// (for example, hits-per-second on an Ingress object).
							object?: {
								// describedObject specifies the descriptions of a object,such as kind,name apiVersion
								describedObject!: {
									// apiVersion is the API version of the referent
									apiVersion?: string

									// kind is the kind of the referent; More info:
									// https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#types-kinds
									kind!: string

									// name is the name of the referent; More info:
									// https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names
									name!: string
								}

								// metric identifies the target metric by name and selector
								metric!: {
									// name is the name of the given metric
									name!: string

									// selector is the string-encoded form of a standard kubernetes label selector for the given metric
									// When set, it is passed as an additional parameter to the metrics server for
									// more specific metrics scoping.
									// When unset, just the metricName will be used to gather metrics.
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
								}

								// target specifies the target value for the given metric
								target!: {
									// averageUtilization is the target value of the average of the
									// resource metric across all relevant pods, represented as a percentage of
									// the requested value of the resource for the pods.
									// Currently only valid for Resource metric source type
									averageUtilization?: int32 & int

									// averageValue is the target value of the average of the
									// metric across all relevant pods (as a quantity)
									averageValue?: matchN(>=1, [int, string]) & (int | =~"^(\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))(([KMGTPE]i)|[numkMGTPE]|([eE](\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))))?$")

									// type represents whether the metric type is Utilization, Value, or AverageValue
									type!: string

									// value is the target value of the metric (as a quantity).
									value?: matchN(>=1, [int, string]) & (int | =~"^(\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))(([KMGTPE]i)|[numkMGTPE]|([eE](\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))))?$")
								}
							}

							// pods refers to a metric describing each pod in the current scale target
							// (for example, transactions-processed-per-second). The values will be
							// averaged together before being compared to the target value.
							pods?: {
								// metric identifies the target metric by name and selector
								metric!: {
									// name is the name of the given metric
									name!: string

									// selector is the string-encoded form of a standard kubernetes label selector for the given metric
									// When set, it is passed as an additional parameter to the metrics server for
									// more specific metrics scoping.
									// When unset, just the metricName will be used to gather metrics.
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
								}

								// target specifies the target value for the given metric
								target!: {
									// averageUtilization is the target value of the average of the
									// resource metric across all relevant pods, represented as a percentage of
									// the requested value of the resource for the pods.
									// Currently only valid for Resource metric source type
									averageUtilization?: int32 & int

									// averageValue is the target value of the average of the
									// metric across all relevant pods (as a quantity)
									averageValue?: matchN(>=1, [int, string]) & (int | =~"^(\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))(([KMGTPE]i)|[numkMGTPE]|([eE](\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))))?$")

									// type represents whether the metric type is Utilization, Value, or AverageValue
									type!: string

									// value is the target value of the metric (as a quantity).
									value?: matchN(>=1, [int, string]) & (int | =~"^(\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))(([KMGTPE]i)|[numkMGTPE]|([eE](\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))))?$")
								}
							}

							// resource refers to a resource metric (such as those specified in
							// requests and limits) known to Kubernetes describing each pod in the
							// current scale target (e.g. CPU or memory). Such metrics are built in to
							// Kubernetes, and have special scaling options on top of those available
							// to normal per-pod metrics using the "pods" source.
							resource?: {
								// name is the name of the resource in question.
								name!: string

								// target specifies the target value for the given metric
								target!: {
									// averageUtilization is the target value of the average of the
									// resource metric across all relevant pods, represented as a percentage of
									// the requested value of the resource for the pods.
									// Currently only valid for Resource metric source type
									averageUtilization?: int32 & int

									// averageValue is the target value of the average of the
									// metric across all relevant pods (as a quantity)
									averageValue?: matchN(>=1, [int, string]) & (int | =~"^(\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))(([KMGTPE]i)|[numkMGTPE]|([eE](\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))))?$")

									// type represents whether the metric type is Utilization, Value, or AverageValue
									type!: string

									// value is the target value of the metric (as a quantity).
									value?: matchN(>=1, [int, string]) & (int | =~"^(\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))(([KMGTPE]i)|[numkMGTPE]|([eE](\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))))?$")
								}
							}

							// type is the type of metric source. It should be one of "ContainerResource", "External",
							// "Object", "Pods" or "Resource", each mapping to a matching field in the object.
							type!: string
						}]
						minReplicas?: int32 & int
					}

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

					// InitContainers allows adding initContainers to the pod definition.
					// Any errors during the execution of an initContainer will lead to a restart of the Pod.
					// More info: https://kubernetes.io/docs/concepts/workloads/pods/init-containers/
					initContainers?: [...{
						name!: _
						...
					}]

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

					// LogFormat for VMAgent to be configured with.
					logFormat?: "default" | "json"

					// LogLevel for VMAgent to be configured with.
					// INFO, WARN, ERROR, FATAL, PANIC
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

					// MinReadySeconds defines a minimum number of seconds to wait before starting update next pod
					// if previous in healthy state
					// Has no effect for VLogs and VMSingle
					minReadySeconds?: int32 & int

					// NodeSelector Define which Nodes the Pods are scheduled on.
					nodeSelector?: [string]: string

					// Paused If set to true all actions on the underlying managed objects are not
					// going to be performed, except for delete actions.
					paused?: bool

					// PersistentVolumeClaimRetentionPolicy allows configuration of PVC retention policy
					persistentVolumeClaimRetentionPolicy?: {
						// WhenDeleted specifies what happens to PVCs created from StatefulSet
						// VolumeClaimTemplates when the StatefulSet is deleted. The default policy
						// of `Retain` causes PVCs to not be affected by StatefulSet deletion. The
						// `Delete` policy causes those PVCs to be deleted.
						whenDeleted?: string

						// WhenScaled specifies what happens to PVCs created from StatefulSet
						// VolumeClaimTemplates when the StatefulSet is scaled down. The default
						// policy of `Retain` causes PVCs to not be affected by a scaledown. The
						// `Delete` policy causes the associated PVCs for any excess pods above
						// the replica count to be deleted.
						whenScaled?: string
					}

					// PodDisruptionBudget created by operator
					podDisruptionBudget?: {
						// An eviction is allowed if at most "maxUnavailable" pods selected by
						// "selector" are unavailable after the eviction, i.e. even in absence of
						// the evicted pod. For example, one can prevent all voluntary evictions
						// by specifying 0. This is a mutually exclusive setting with "minAvailable".
						maxUnavailable?: matchN(>=1, [int, string]) & (int | string)

						// An eviction is allowed if at least "minAvailable" pods selected by
						// "selector" will still be available after the eviction, i.e. even in the
						// absence of the evicted pod. So for example you can prevent all voluntary
						// evictions by specifying "100%".
						minAvailable?: matchN(>=1, [int, string]) & (int | string)

						// replaces default labels selector generated by operator
						// it's useful when you need to create custom budget
						selectorLabels?: [string]: string

						// UnhealthyPodEvictionPolicy defines the criteria for when unhealthy pods
						//
						// Valid policies are IfHealthyBudget and AlwaysAllow.
						// If no policy is specified, the default behavior will be used,
						// which corresponds to the IfHealthyBudget policy.
						unhealthyPodEvictionPolicy?: "IfHealthyBudget" | "AlwaysAllow"
					}

					// PodMetadata configures Labels and Annotations which are propagated to the vmagent pods.
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

					// Port listen address
					port?: string

					// PreStopSleepSeconds defines the number of seconds to sleep in the preStop lifecycle hook.
					// It gives time for load balancers to remove the pod from rotation before the pod is terminated.
					// Defaults to 15 for applicable components. Set to 0 to disable.
					preStopSleepSeconds?: int32 & int

					// PriorityClassName class assigned to the Pods
					priorityClassName?: string

					// ReadinessGates defines pod readiness gates
					readinessGates?: [...{
						// ConditionType refers to a condition in the pod's condition list with matching type.
						conditionType!: string
					}]

					// ReadinessProbe that will be added to CR pod
					readinessProbe?: {
						...
					}

					// RemoteWriteSettings defines global settings for all remoteWrite urls.
					remoteWriteSettings?: {
						// Interval for flushing the data to remote storage. (default 1s)
						flushInterval?: =~"[0-9]+(ms|s|m|h)"

						// Labels in the form 'name=value' to add to all the metrics before sending
						// them. This overrides the label if it already exists.
						label?: [string]: string

						// The maximum size in bytes of unpacked request to send to remote storage
						maxBlockSize?: int32 & int

						// The maximum file-based buffer size in bytes at -remoteWrite.tmpDataPath
						maxDiskUsagePerURL?: null | bool | number | string | [...] | {
							...
						}

						// The number of concurrent queues
						queues?: int32 & int

						// Whether to show -remoteWrite.url in the exported metrics. It is hidden by
						// default, since it can contain sensitive auth info
						showURL?: bool

						// Path to directory where temporary data for remote write component is stored
						// (default vmagent-remotewrite-data)
						tmpDataPath?: string

						// Configures vmagent accepting data via the same multitenant endpoints as
						// vminsert at VictoriaMetrics cluster does,
						// see [here](https://docs.victoriametrics.com/victoriametrics/vmagent/#multitenancy).
						// it's global setting and affects all remote storage configurations
						useMultiTenantMode?: bool
					}

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

					// The number of old ReplicaSets to retain to allow rollback in deployment or
					// maximum number of revisions that will be maintained in the Deployment revision history.
					// Has no effect at StatefulSets
					// Defaults to 10.
					revisionHistoryLimitCount?: int32 & int

					// RollingUpdate - overrides deployment update params.
					rollingUpdate?: {
						// The maximum number of pods that can be scheduled above the desired number of
						// pods.
						// Value can be an absolute number (ex: 5) or a percentage of desired pods (ex: 10%).
						// This can not be 0 if MaxUnavailable is 0.
						// Absolute number is calculated from percentage by rounding up.
						// Defaults to 25%.
						// Example: when this is set to 30%, the new ReplicaSet can be scaled up immediately when
						// the rolling update starts, such that the total number of old and new pods do not exceed
						// 130% of desired pods. Once old pods have been killed,
						// new ReplicaSet can be scaled up further, ensuring that total number of pods running
						// at any time during the update is at most 130% of desired pods.
						maxSurge?: matchN(>=1, [int, string]) & (int | string)

						// The maximum number of pods that can be unavailable during the update.
						// Value can be an absolute number (ex: 5) or a percentage of desired pods (ex: 10%).
						// Absolute number is calculated from percentage by rounding down.
						// This can not be 0 if MaxSurge is 0.
						// Defaults to 25%.
						// Example: when this is set to 30%, the old ReplicaSet can be scaled down to 70% of desired pods
						// immediately when the rolling update starts. Once new pods are ready, old ReplicaSet
						// can be scaled down further, followed by scaling up the new ReplicaSet, ensuring
						// that the total number of pods available at all times during the update is at
						// least 70% of desired pods.
						maxUnavailable?: matchN(>=1, [int, string]) & (int | string)
					}

					// RuntimeClassName - defines runtime class for kubernetes pod.
					// https://kubernetes.io/docs/concepts/containers/runtime-class/
					runtimeClassName?: string

					// SchedulerName - defines kubernetes scheduler name
					schedulerName?: string

					// Secrets is a list of Secrets in the same namespace as the Application
					// object, which shall be mounted into the Application container
					// at /etc/vm/secrets/SECRET_NAME folder
					secrets?: [...string]

					// SecurityContext holds pod-level security attributes and common container settings.
					// This defaults to the default PodSecurityContext.
					securityContext?: {
						...
					}

					// ServiceAccountName is the name of the ServiceAccount to use to run the pods
					serviceAccountName?: string

					// StartupProbe that will be added to CR pod
					startupProbe?: {
						...
					}

					// StatefulMode enables StatefulSet for `VMAgent` instead of Deployment
					// it allows using persistent storage for vmagent's persistentQueue
					statefulMode?: bool

					// StatefulRollingUpdateStrategy allows configuration for strategyType
					// set it to RollingUpdate for disabling operator statefulSet rollingUpdate
					statefulRollingUpdateStrategy?: string

					// StatefulRollingUpdateStrategyBehavior defines customized behavior for rolling updates.
					// It applies if the RollingUpdateStrategy is set to OnDelete, which is the default.
					statefulRollingUpdateStrategyBehavior?: {
						// MaxUnavailable defines the maximum number of pods that can be unavailable during the update.
						// It can be specified as an absolute number (e.g. 2) or a percentage of the
						// total pods (e.g. "50%").
						// For example, if set to 100%, all pods will be upgraded at once, minimizing downtime when needed.
						maxUnavailable?: matchN(>=1, [int, string]) & (int | string)
					}

					// StatefulStorage configures storage for StatefulSet
					statefulStorage?: {
						// EmptyDirVolumeSource to be used by the Prometheus StatefulSets. If specified,
						// used in place of any volumeClaimTemplate. More
						// info: https://kubernetes.io/docs/concepts/storage/volumes/#emptydir
						emptyDir?: {
							// medium represents what type of storage medium should back this directory.
							// The default is "" which means to use the node's default medium.
							// Must be an empty string (default) or Memory.
							// More info: https://kubernetes.io/docs/concepts/storage/volumes#emptydir
							medium?: string

							// mode specifies the permission bits for the emptyDir directory, in numeric
							// notation (e.g., 0755, 01777). Must be a value between 0000 and 01777.
							// If not specified, defaults to 0777.
							// This might be in conflict with other options that affect the file
							// mode, like fsGroup. If fsGroup is specified, the fsGroup permissions
							// will override the mode specified here.
							// This field has no effect on Windows.
							// This field is alpha and requires EmptyDirVolumeMode featuregate to be enabled.
							mode?: int32 & int

							// sizeLimit is the total amount of local storage required for this EmptyDir volume.
							// The size limit is also applicable for memory medium.
							// The maximum usage on memory medium EmptyDir would be the minimum value between
							// the SizeLimit specified here and the sum of memory limits of all containers in a pod.
							// The default is nil which means that the limit is undefined.
							// More info: https://kubernetes.io/docs/concepts/storage/volumes#emptydir
							sizeLimit?: matchN(>=1, [int, string]) & (int | =~"^(\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))(([KMGTPE]i)|[numkMGTPE]|([eE](\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))))?$")
						}

						// A PVC spec to be used by the StatefulSets/Deployments.
						volumeClaimTemplate?: {
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

							// EmbeddedMetadata contains metadata relevant to an EmbeddedResource.
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

							// Spec defines the desired characteristics of a volume requested by a pod author.
							// More info: https://kubernetes.io/docs/concepts/storage/persistent-volumes#persistentvolumeclaims
							spec?: {
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

							// Status represents the current information/status of a persistent volume claim.
							// Read-only.
							// More info: https://kubernetes.io/docs/concepts/storage/persistent-volumes#persistentvolumeclaims
							status?: {
								// accessModes contains the actual access modes the volume backing the PVC has.
								// More info: https://kubernetes.io/docs/concepts/storage/persistent-volumes#access-modes-1
								accessModes?: [...string]

								// allocatedResourceStatuses stores status of resource being resized for the given PVC.
								// Key names follow standard Kubernetes label syntax. Valid values are either:
								// * Un-prefixed keys:
								// - storage - the capacity of the volume.
								// * Custom resources must use implementation-defined prefixed names such as
								// "example.com/my-custom-resource"
								// Apart from above values - keys that are unprefixed or have kubernetes.io prefix are considered
								// reserved and hence may not be used.
								//
								// ClaimResourceStatus can be in any of following states:
								// - ControllerResizeInProgress:
								// State set when resize controller starts resizing the volume in control-plane.
								// - ControllerResizeFailed:
								// State set when resize has failed in resize controller with a terminal error.
								// - NodeResizePending:
								// State set when resize controller has finished resizing the volume but further resizing of
								// volume is needed on the node.
								// - NodeResizeInProgress:
								// State set when kubelet starts resizing the volume.
								// - NodeResizeFailed:
								// State set when resizing has failed in kubelet with a terminal error. Transient errors don't set
								// NodeResizeFailed.
								// For example: if expanding a PVC for more capacity - this field can be one of
								// the following states:
								// - pvc.status.allocatedResourceStatus['storage'] = "ControllerResizeInProgress"
								// - pvc.status.allocatedResourceStatus['storage'] = "ControllerResizeFailed"
								// - pvc.status.allocatedResourceStatus['storage'] = "NodeResizePending"
								// - pvc.status.allocatedResourceStatus['storage'] = "NodeResizeInProgress"
								// - pvc.status.allocatedResourceStatus['storage'] = "NodeResizeFailed"
								// When this field is not set, it means that no resize operation is in progress for the given PVC.
								//
								// A controller that receives PVC update with previously unknown resourceName or ClaimResourceStatus
								// should ignore the update for the purpose it was designed. For example - a controller that
								// only is responsible for resizing capacity of the volume, should ignore PVC
								// updates that change other valid
								// resources associated with PVC.
								allocatedResourceStatuses?: [string]: string

								// allocatedResources tracks the resources allocated to a PVC including its capacity.
								// Key names follow standard Kubernetes label syntax. Valid values are either:
								// * Un-prefixed keys:
								// - storage - the capacity of the volume.
								// * Custom resources must use implementation-defined prefixed names such as
								// "example.com/my-custom-resource"
								// Apart from above values - keys that are unprefixed or have kubernetes.io prefix are considered
								// reserved and hence may not be used.
								//
								// Capacity reported here may be larger than the actual capacity when a volume expansion operation
								// is requested.
								// For storage quota, the larger value from allocatedResources and PVC.spec.resources is used.
								// If allocatedResources is not set, PVC.spec.resources alone is used for quota calculation.
								// If a volume expansion capacity request is lowered, allocatedResources is only
								// lowered if there are no expansion operations in progress and if the actual volume capacity
								// is equal or lower than the requested capacity.
								//
								// A controller that receives PVC update with previously unknown resourceName
								// should ignore the update for the purpose it was designed. For example - a controller that
								// only is responsible for resizing capacity of the volume, should ignore PVC
								// updates that change other valid
								// resources associated with PVC.
								allocatedResources?: [string]: matchN(>=1, [int, string]) & (int | =~"^(\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))(([KMGTPE]i)|[numkMGTPE]|([eE](\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))))?$")

								// capacity represents the actual resources of the underlying volume.
								capacity?: [string]: matchN(>=1, [int, string]) & (int | =~"^(\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))(([KMGTPE]i)|[numkMGTPE]|([eE](\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))))?$")

								// conditions is the current Condition of persistent volume claim. If underlying
								// persistent volume is being
								// resized then the Condition will be set to 'Resizing'.
								conditions?: [...{
									// lastProbeTime is the time we probed the condition.
									lastProbeTime?: time.Time

									// lastTransitionTime is the time the condition transitioned from one status to another.
									lastTransitionTime?: time.Time

									// message is the human-readable message indicating details about last transition.
									message?: string

									// reason is a unique, this should be a short, machine understandable string that gives the reason
									// for condition's last transition. If it reports "Resizing" that means the underlying
									// persistent volume is being resized.
									reason?: string

									// Status is the status of the condition.
									// Can be True, False, Unknown.
									// More info:
									// https://kubernetes.io/docs/reference/kubernetes-api/config-and-storage-resources/persistent-volume-claim-v1/#:~:text=state%20of%20pvc-,conditions.status,-(string)%2C%20required
									status!: string

									// Type is the type of the condition.
									// More info:
									// https://kubernetes.io/docs/reference/kubernetes-api/config-and-storage-resources/persistent-volume-claim-v1/#:~:text=set%20to%20%27ResizeStarted%27.-,PersistentVolumeClaimCondition,-contains%20details%20about
									type!: string
								}]

								// currentVolumeAttributesClassName is the current name of the
								// VolumeAttributesClass the PVC is using.
								// When unset, there is no VolumeAttributeClass applied to this PersistentVolumeClaim
								currentVolumeAttributesClassName?: string

								// healthStatus contains the latest controller-reported health information
								// for the volume bound to this claim.
								healthStatus?: {
									// conditions is the set of adverse conditions reported by
									// the CSI controller plugin. An empty list means no adverse condition.
									// At most 16 conditions may be reported.
									healthConditions?: [...{
										// message is a human-readable description.
										// Maximum permitted length of a message is 1024 bytes.
										message?: string

										// reason is a brief CamelCase machine-parseable reason.
										// Together with status it forms the unique identity of a condition entry.
										// Maximum permitted length of a reason is 256 bytes.
										reason!: string

										// status is the machine-parseable health category.
										// Possible values:
										// - "Inaccessible": the volume cannot be accessed.
										// - "DataLoss": data loss has been detected on the volume.
										// - "Degraded": the volume is functioning with reduced capability.
										status!: "DataLoss" | "Degraded" | "Inaccessible"
									}]

									// lastTransitionTime is when the current set of conditions first appeared.
									lastTransitionTime?: time.Time
								}

								// ModifyVolumeStatus represents the status object of ControllerModifyVolume operation.
								// When this is unset, there is no ModifyVolume operation being attempted.
								modifyVolumeStatus?: {
									// status is the status of the ControllerModifyVolume operation. It can be in
									// any of following states:
									// - Pending
									// Pending indicates that the PersistentVolumeClaim cannot be modified due to
									// unmet requirements, such as
									// the specified VolumeAttributesClass not existing.
									// - InProgress
									// InProgress indicates that the volume is being modified.
									// - Infeasible
									// Infeasible indicates that the request has been rejected as invalid by the CSI driver. To
									// resolve the error, a valid VolumeAttributesClass needs to be specified.
									// Note: New statuses can be added in the future. Consumers should check for
									// unknown statuses and fail appropriately.
									status!: string

									// targetVolumeAttributesClassName is the name of the VolumeAttributesClass the
									// PVC currently being reconciled
									targetVolumeAttributesClassName?: string
								}

								// phase represents the current phase of PersistentVolumeClaim.
								phase?: string
							}
						}
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

					// UpdateStrategy - overrides default update strategy.
					// works only for deployments, statefulset always use OnDelete.
					updateStrategy?: "Recreate" | "RollingUpdate"

					// UseDefaultResources controls resource settings
					// By default, operator sets built-in resource requirements
					useDefaultResources?: bool

					// UseStrictSecurity enables strict security mode for component
					// it restricts disk writes access
					// uses non-root user out of the box
					// drops not needed security permissions
					useStrictSecurity?: bool

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
				}
			}

			// VMCluster defines VictoriaMetrics cluster database
			vmcluster?: {
				// Name specifies the static name to be used for the new VMCluster.
				name?: string

				// Spec defines the desired state of a new or update spec for existing VMCluster.
				spec?: null | bool | number | string | [...] | {
					...
				}
			}

			// VMSingle defines VictoriaMetrics single-node database.
			vmsingle?: {
				// Name specifies the static name to be used for the new VMSingle.
				name?: string

				// Spec defines the desired state of a new or update spec for existing VMSingle.
				spec?: null | bool | number | string | [...] | {
					...
				}
			}
		}

		// Zones is a list of zones to update. Each item in the list represents a "zone"
		// within the distributed setup.
		zones?: [...{
			// Name defines a name of zone, which can be used in zoneCommon spec as %ZONE%
			name!: string

			// RemoteWrite defines VMAgent remote write settings for given zone
			remoteWrite?: null | bool | number | string | [...] | {
				...
			}

			// TrafficMode defines allowed traffic mode for a zone: read-only, write-only,
			// read-write, maintenance
			trafficMode?: "read-only" | "write-only" | "read-write" | "maintenance"

			// VMAgent defines VMAgent to balance incoming traffic between VMClusters.
			vmagent?: {
				// Name specifies the static name to be used for the VMAgent when Spec is provided.
				name?: string

				// Spec defines the desired state of a new VMAgent.
				spec?: {
					// Affinity If specified, the pod's scheduling constraints.
					affinity?: {
						...
					}

					// ClaimTemplates allows adding additional VolumeClaimTemplates for VMAgent in StatefulMode
					claimTemplates?: [...{
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

						// Standard object's metadata.
						// More info:
						// https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#metadata
						metadata?: {
							...
						}

						// spec defines the desired characteristics of a volume requested by a pod author.
						// More info: https://kubernetes.io/docs/concepts/storage/persistent-volumes#persistentvolumeclaims
						spec?: {
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

						// status represents the current information/status of a persistent volume claim.
						// Read-only.
						// More info: https://kubernetes.io/docs/concepts/storage/persistent-volumes#persistentvolumeclaims
						status?: {
							// accessModes contains the actual access modes the volume backing the PVC has.
							// More info: https://kubernetes.io/docs/concepts/storage/persistent-volumes#access-modes-1
							accessModes?: [...string]

							// allocatedResourceStatuses stores status of resource being resized for the given PVC.
							// Key names follow standard Kubernetes label syntax. Valid values are either:
							// * Un-prefixed keys:
							// - storage - the capacity of the volume.
							// * Custom resources must use implementation-defined prefixed names such as
							// "example.com/my-custom-resource"
							// Apart from above values - keys that are unprefixed or have kubernetes.io prefix are considered
							// reserved and hence may not be used.
							//
							// ClaimResourceStatus can be in any of following states:
							// - ControllerResizeInProgress:
							// State set when resize controller starts resizing the volume in control-plane.
							// - ControllerResizeFailed:
							// State set when resize has failed in resize controller with a terminal error.
							// - NodeResizePending:
							// State set when resize controller has finished resizing the volume but further resizing of
							// volume is needed on the node.
							// - NodeResizeInProgress:
							// State set when kubelet starts resizing the volume.
							// - NodeResizeFailed:
							// State set when resizing has failed in kubelet with a terminal error. Transient errors don't set
							// NodeResizeFailed.
							// For example: if expanding a PVC for more capacity - this field can be one of
							// the following states:
							// - pvc.status.allocatedResourceStatus['storage'] = "ControllerResizeInProgress"
							// - pvc.status.allocatedResourceStatus['storage'] = "ControllerResizeFailed"
							// - pvc.status.allocatedResourceStatus['storage'] = "NodeResizePending"
							// - pvc.status.allocatedResourceStatus['storage'] = "NodeResizeInProgress"
							// - pvc.status.allocatedResourceStatus['storage'] = "NodeResizeFailed"
							// When this field is not set, it means that no resize operation is in progress for the given PVC.
							//
							// A controller that receives PVC update with previously unknown resourceName or ClaimResourceStatus
							// should ignore the update for the purpose it was designed. For example - a controller that
							// only is responsible for resizing capacity of the volume, should ignore PVC
							// updates that change other valid
							// resources associated with PVC.
							allocatedResourceStatuses?: [string]: string

							// allocatedResources tracks the resources allocated to a PVC including its capacity.
							// Key names follow standard Kubernetes label syntax. Valid values are either:
							// * Un-prefixed keys:
							// - storage - the capacity of the volume.
							// * Custom resources must use implementation-defined prefixed names such as
							// "example.com/my-custom-resource"
							// Apart from above values - keys that are unprefixed or have kubernetes.io prefix are considered
							// reserved and hence may not be used.
							//
							// Capacity reported here may be larger than the actual capacity when a volume expansion operation
							// is requested.
							// For storage quota, the larger value from allocatedResources and PVC.spec.resources is used.
							// If allocatedResources is not set, PVC.spec.resources alone is used for quota calculation.
							// If a volume expansion capacity request is lowered, allocatedResources is only
							// lowered if there are no expansion operations in progress and if the actual volume capacity
							// is equal or lower than the requested capacity.
							//
							// A controller that receives PVC update with previously unknown resourceName
							// should ignore the update for the purpose it was designed. For example - a controller that
							// only is responsible for resizing capacity of the volume, should ignore PVC
							// updates that change other valid
							// resources associated with PVC.
							allocatedResources?: [string]: matchN(>=1, [int, string]) & (int | =~"^(\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))(([KMGTPE]i)|[numkMGTPE]|([eE](\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))))?$")

							// capacity represents the actual resources of the underlying volume.
							capacity?: [string]: matchN(>=1, [int, string]) & (int | =~"^(\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))(([KMGTPE]i)|[numkMGTPE]|([eE](\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))))?$")

							// conditions is the current Condition of persistent volume claim. If underlying
							// persistent volume is being
							// resized then the Condition will be set to 'Resizing'.
							conditions?: [...{
								// lastProbeTime is the time we probed the condition.
								lastProbeTime?: time.Time

								// lastTransitionTime is the time the condition transitioned from one status to another.
								lastTransitionTime?: time.Time

								// message is the human-readable message indicating details about last transition.
								message?: string

								// reason is a unique, this should be a short, machine understandable string that gives the reason
								// for condition's last transition. If it reports "Resizing" that means the underlying
								// persistent volume is being resized.
								reason?: string

								// Status is the status of the condition.
								// Can be True, False, Unknown.
								// More info:
								// https://kubernetes.io/docs/reference/kubernetes-api/config-and-storage-resources/persistent-volume-claim-v1/#:~:text=state%20of%20pvc-,conditions.status,-(string)%2C%20required
								status!: string

								// Type is the type of the condition.
								// More info:
								// https://kubernetes.io/docs/reference/kubernetes-api/config-and-storage-resources/persistent-volume-claim-v1/#:~:text=set%20to%20%27ResizeStarted%27.-,PersistentVolumeClaimCondition,-contains%20details%20about
								type!: string
							}]

							// currentVolumeAttributesClassName is the current name of the
							// VolumeAttributesClass the PVC is using.
							// When unset, there is no VolumeAttributeClass applied to this PersistentVolumeClaim
							currentVolumeAttributesClassName?: string

							// healthStatus contains the latest controller-reported health information
							// for the volume bound to this claim.
							healthStatus?: {
								// conditions is the set of adverse conditions reported by
								// the CSI controller plugin. An empty list means no adverse condition.
								// At most 16 conditions may be reported.
								healthConditions?: [...{
									// message is a human-readable description.
									// Maximum permitted length of a message is 1024 bytes.
									message?: string

									// reason is a brief CamelCase machine-parseable reason.
									// Together with status it forms the unique identity of a condition entry.
									// Maximum permitted length of a reason is 256 bytes.
									reason!: string

									// status is the machine-parseable health category.
									// Possible values:
									// - "Inaccessible": the volume cannot be accessed.
									// - "DataLoss": data loss has been detected on the volume.
									// - "Degraded": the volume is functioning with reduced capability.
									status!: "DataLoss" | "Degraded" | "Inaccessible"
								}]

								// lastTransitionTime is when the current set of conditions first appeared.
								lastTransitionTime?: time.Time
							}

							// ModifyVolumeStatus represents the status object of ControllerModifyVolume operation.
							// When this is unset, there is no ModifyVolume operation being attempted.
							modifyVolumeStatus?: {
								// status is the status of the ControllerModifyVolume operation. It can be in
								// any of following states:
								// - Pending
								// Pending indicates that the PersistentVolumeClaim cannot be modified due to
								// unmet requirements, such as
								// the specified VolumeAttributesClass not existing.
								// - InProgress
								// InProgress indicates that the volume is being modified.
								// - Infeasible
								// Infeasible indicates that the request has been rejected as invalid by the CSI driver. To
								// resolve the error, a valid VolumeAttributesClass needs to be specified.
								// Note: New statuses can be added in the future. Consumers should check for
								// unknown statuses and fail appropriately.
								status!: string

								// targetVolumeAttributesClassName is the name of the VolumeAttributesClass the
								// PVC currently being reconciled
								targetVolumeAttributesClassName?: string
							}

							// phase represents the current phase of PersistentVolumeClaim.
							phase?: string
						}
					}]

					// ConfigMaps is a list of ConfigMaps in the same namespace as the Application
					// object, which shall be mounted into the Application container
					// at /etc/vm/configs/CONFIGMAP_NAME folder
					configMaps?: [...string]

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

					// EnableServiceLinks indicates whether information about services should be injected into pod's
					// environment variables, matching the syntax of Docker links.
					// Optional: Defaults to true.
					enableServiceLinks?: bool

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

					// Configures horizontal pod autoscaling.
					hpa?: {
						// HorizontalPodAutoscalerBehavior configures the scaling behavior of the target
						// in both Up and Down directions (scaleUp and scaleDown fields respectively).
						behaviour?: {
							// scaleDown is scaling policy for scaling Down.
							// If not set, the default value is to allow to scale down to minReplicas pods, with a
							// 300 second stabilization window (i.e., the highest recommendation for
							// the last 300sec is used).
							scaleDown?: {
								// policies is a list of potential scaling polices which can be used during scaling.
								// If not set, use the default values:
								// - For scale up: allow doubling the number of pods, or an absolute change of 4
								// pods in a 15s window.
								// - For scale down: allow all pods to be removed in a 15s window.
								policies?: [...{
									// periodSeconds specifies the window of time for which the policy should hold true.
									// PeriodSeconds must be greater than zero and less than or equal to 1800 (30 min).
									periodSeconds!: int32 & int

									// type is used to specify the scaling policy.
									type!: string

									// value contains the amount of change which is permitted by the policy.
									// It must be greater than zero
									value!: int32 & int
								}]

								// selectPolicy is used to specify which policy should be used.
								// If not set, the default value Max is used.
								selectPolicy?: string

								// stabilizationWindowSeconds is the number of seconds for which past recommendations should be
								// considered while scaling up or scaling down.
								// StabilizationWindowSeconds must be greater than or equal to zero and less
								// than or equal to 3600 (one hour).
								// If not set, use the default values:
								// - For scale up: 0 (i.e. no stabilization is done).
								// - For scale down: 300 (i.e. the stabilization window is 300 seconds long).
								stabilizationWindowSeconds?: int32 & int

								// tolerance is the tolerance on the ratio between the current and desired
								// metric value under which no updates are made to the desired number of
								// replicas (e.g. 0.01 for 1%). Must be greater than or equal to zero. If not
								// set, the default cluster-wide tolerance is applied (by default 10%).
								//
								// For example, if autoscaling is configured with a memory consumption target of 100Mi,
								// and scale-down and scale-up tolerances of 5% and 1% respectively, scaling will be
								// triggered when the actual consumption falls below 95Mi or exceeds 101Mi.
								tolerance?: matchN(>=1, [int, string]) & (int | =~"^(\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))(([KMGTPE]i)|[numkMGTPE]|([eE](\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))))?$")
							}

							// scaleUp is scaling policy for scaling Up.
							// If not set, the default value is the higher of:
							// * increase no more than 4 pods per 60 seconds
							// * double the number of pods per 60 seconds
							// No stabilization is used.
							scaleUp?: {
								// policies is a list of potential scaling polices which can be used during scaling.
								// If not set, use the default values:
								// - For scale up: allow doubling the number of pods, or an absolute change of 4
								// pods in a 15s window.
								// - For scale down: allow all pods to be removed in a 15s window.
								policies?: [...{
									// periodSeconds specifies the window of time for which the policy should hold true.
									// PeriodSeconds must be greater than zero and less than or equal to 1800 (30 min).
									periodSeconds!: int32 & int

									// type is used to specify the scaling policy.
									type!: string

									// value contains the amount of change which is permitted by the policy.
									// It must be greater than zero
									value!: int32 & int
								}]

								// selectPolicy is used to specify which policy should be used.
								// If not set, the default value Max is used.
								selectPolicy?: string

								// stabilizationWindowSeconds is the number of seconds for which past recommendations should be
								// considered while scaling up or scaling down.
								// StabilizationWindowSeconds must be greater than or equal to zero and less
								// than or equal to 3600 (one hour).
								// If not set, use the default values:
								// - For scale up: 0 (i.e. no stabilization is done).
								// - For scale down: 300 (i.e. the stabilization window is 300 seconds long).
								stabilizationWindowSeconds?: int32 & int

								// tolerance is the tolerance on the ratio between the current and desired
								// metric value under which no updates are made to the desired number of
								// replicas (e.g. 0.01 for 1%). Must be greater than or equal to zero. If not
								// set, the default cluster-wide tolerance is applied (by default 10%).
								//
								// For example, if autoscaling is configured with a memory consumption target of 100Mi,
								// and scale-down and scale-up tolerances of 5% and 1% respectively, scaling will be
								// triggered when the actual consumption falls below 95Mi or exceeds 101Mi.
								tolerance?: matchN(>=1, [int, string]) & (int | =~"^(\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))(([KMGTPE]i)|[numkMGTPE]|([eE](\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))))?$")
							}
						}
						maxReplicas?: int32 & int
						metrics?: [...{
							// containerResource refers to a resource metric (such as those specified in
							// requests and limits) known to Kubernetes describing a single container in
							// each pod of the current scale target (e.g. CPU or memory). Such metrics are
							// built in to Kubernetes, and have special scaling options on top of those
							// available to normal per-pod metrics using the "pods" source.
							containerResource?: {
								// container is the name of the container in the pods of the scaling target
								container!: string

								// name is the name of the resource in question.
								name!: string

								// target specifies the target value for the given metric
								target!: {
									// averageUtilization is the target value of the average of the
									// resource metric across all relevant pods, represented as a percentage of
									// the requested value of the resource for the pods.
									// Currently only valid for Resource metric source type
									averageUtilization?: int32 & int

									// averageValue is the target value of the average of the
									// metric across all relevant pods (as a quantity)
									averageValue?: matchN(>=1, [int, string]) & (int | =~"^(\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))(([KMGTPE]i)|[numkMGTPE]|([eE](\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))))?$")

									// type represents whether the metric type is Utilization, Value, or AverageValue
									type!: string

									// value is the target value of the metric (as a quantity).
									value?: matchN(>=1, [int, string]) & (int | =~"^(\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))(([KMGTPE]i)|[numkMGTPE]|([eE](\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))))?$")
								}
							}

							// external refers to a global metric that is not associated
							// with any Kubernetes object. It allows autoscaling based on information
							// coming from components running outside of cluster
							// (for example length of queue in cloud messaging service, or
							// QPS from loadbalancer running outside of cluster).
							external?: {
								// metric identifies the target metric by name and selector
								metric!: {
									// name is the name of the given metric
									name!: string

									// selector is the string-encoded form of a standard kubernetes label selector for the given metric
									// When set, it is passed as an additional parameter to the metrics server for
									// more specific metrics scoping.
									// When unset, just the metricName will be used to gather metrics.
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
								}

								// target specifies the target value for the given metric
								target!: {
									// averageUtilization is the target value of the average of the
									// resource metric across all relevant pods, represented as a percentage of
									// the requested value of the resource for the pods.
									// Currently only valid for Resource metric source type
									averageUtilization?: int32 & int

									// averageValue is the target value of the average of the
									// metric across all relevant pods (as a quantity)
									averageValue?: matchN(>=1, [int, string]) & (int | =~"^(\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))(([KMGTPE]i)|[numkMGTPE]|([eE](\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))))?$")

									// type represents whether the metric type is Utilization, Value, or AverageValue
									type!: string

									// value is the target value of the metric (as a quantity).
									value?: matchN(>=1, [int, string]) & (int | =~"^(\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))(([KMGTPE]i)|[numkMGTPE]|([eE](\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))))?$")
								}
							}

							// object refers to a metric describing a single kubernetes object
							// (for example, hits-per-second on an Ingress object).
							object?: {
								// describedObject specifies the descriptions of a object,such as kind,name apiVersion
								describedObject!: {
									// apiVersion is the API version of the referent
									apiVersion?: string

									// kind is the kind of the referent; More info:
									// https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#types-kinds
									kind!: string

									// name is the name of the referent; More info:
									// https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names
									name!: string
								}

								// metric identifies the target metric by name and selector
								metric!: {
									// name is the name of the given metric
									name!: string

									// selector is the string-encoded form of a standard kubernetes label selector for the given metric
									// When set, it is passed as an additional parameter to the metrics server for
									// more specific metrics scoping.
									// When unset, just the metricName will be used to gather metrics.
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
								}

								// target specifies the target value for the given metric
								target!: {
									// averageUtilization is the target value of the average of the
									// resource metric across all relevant pods, represented as a percentage of
									// the requested value of the resource for the pods.
									// Currently only valid for Resource metric source type
									averageUtilization?: int32 & int

									// averageValue is the target value of the average of the
									// metric across all relevant pods (as a quantity)
									averageValue?: matchN(>=1, [int, string]) & (int | =~"^(\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))(([KMGTPE]i)|[numkMGTPE]|([eE](\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))))?$")

									// type represents whether the metric type is Utilization, Value, or AverageValue
									type!: string

									// value is the target value of the metric (as a quantity).
									value?: matchN(>=1, [int, string]) & (int | =~"^(\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))(([KMGTPE]i)|[numkMGTPE]|([eE](\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))))?$")
								}
							}

							// pods refers to a metric describing each pod in the current scale target
							// (for example, transactions-processed-per-second). The values will be
							// averaged together before being compared to the target value.
							pods?: {
								// metric identifies the target metric by name and selector
								metric!: {
									// name is the name of the given metric
									name!: string

									// selector is the string-encoded form of a standard kubernetes label selector for the given metric
									// When set, it is passed as an additional parameter to the metrics server for
									// more specific metrics scoping.
									// When unset, just the metricName will be used to gather metrics.
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
								}

								// target specifies the target value for the given metric
								target!: {
									// averageUtilization is the target value of the average of the
									// resource metric across all relevant pods, represented as a percentage of
									// the requested value of the resource for the pods.
									// Currently only valid for Resource metric source type
									averageUtilization?: int32 & int

									// averageValue is the target value of the average of the
									// metric across all relevant pods (as a quantity)
									averageValue?: matchN(>=1, [int, string]) & (int | =~"^(\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))(([KMGTPE]i)|[numkMGTPE]|([eE](\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))))?$")

									// type represents whether the metric type is Utilization, Value, or AverageValue
									type!: string

									// value is the target value of the metric (as a quantity).
									value?: matchN(>=1, [int, string]) & (int | =~"^(\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))(([KMGTPE]i)|[numkMGTPE]|([eE](\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))))?$")
								}
							}

							// resource refers to a resource metric (such as those specified in
							// requests and limits) known to Kubernetes describing each pod in the
							// current scale target (e.g. CPU or memory). Such metrics are built in to
							// Kubernetes, and have special scaling options on top of those available
							// to normal per-pod metrics using the "pods" source.
							resource?: {
								// name is the name of the resource in question.
								name!: string

								// target specifies the target value for the given metric
								target!: {
									// averageUtilization is the target value of the average of the
									// resource metric across all relevant pods, represented as a percentage of
									// the requested value of the resource for the pods.
									// Currently only valid for Resource metric source type
									averageUtilization?: int32 & int

									// averageValue is the target value of the average of the
									// metric across all relevant pods (as a quantity)
									averageValue?: matchN(>=1, [int, string]) & (int | =~"^(\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))(([KMGTPE]i)|[numkMGTPE]|([eE](\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))))?$")

									// type represents whether the metric type is Utilization, Value, or AverageValue
									type!: string

									// value is the target value of the metric (as a quantity).
									value?: matchN(>=1, [int, string]) & (int | =~"^(\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))(([KMGTPE]i)|[numkMGTPE]|([eE](\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))))?$")
								}
							}

							// type is the type of metric source. It should be one of "ContainerResource", "External",
							// "Object", "Pods" or "Resource", each mapping to a matching field in the object.
							type!: string
						}]
						minReplicas?: int32 & int
					}

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

					// InitContainers allows adding initContainers to the pod definition.
					// Any errors during the execution of an initContainer will lead to a restart of the Pod.
					// More info: https://kubernetes.io/docs/concepts/workloads/pods/init-containers/
					initContainers?: [...{
						name!: _
						...
					}]

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

					// LogFormat for VMAgent to be configured with.
					logFormat?: "default" | "json"

					// LogLevel for VMAgent to be configured with.
					// INFO, WARN, ERROR, FATAL, PANIC
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

					// MinReadySeconds defines a minimum number of seconds to wait before starting update next pod
					// if previous in healthy state
					// Has no effect for VLogs and VMSingle
					minReadySeconds?: int32 & int

					// NodeSelector Define which Nodes the Pods are scheduled on.
					nodeSelector?: [string]: string

					// Paused If set to true all actions on the underlying managed objects are not
					// going to be performed, except for delete actions.
					paused?: bool

					// PersistentVolumeClaimRetentionPolicy allows configuration of PVC retention policy
					persistentVolumeClaimRetentionPolicy?: {
						// WhenDeleted specifies what happens to PVCs created from StatefulSet
						// VolumeClaimTemplates when the StatefulSet is deleted. The default policy
						// of `Retain` causes PVCs to not be affected by StatefulSet deletion. The
						// `Delete` policy causes those PVCs to be deleted.
						whenDeleted?: string

						// WhenScaled specifies what happens to PVCs created from StatefulSet
						// VolumeClaimTemplates when the StatefulSet is scaled down. The default
						// policy of `Retain` causes PVCs to not be affected by a scaledown. The
						// `Delete` policy causes the associated PVCs for any excess pods above
						// the replica count to be deleted.
						whenScaled?: string
					}

					// PodDisruptionBudget created by operator
					podDisruptionBudget?: {
						// An eviction is allowed if at most "maxUnavailable" pods selected by
						// "selector" are unavailable after the eviction, i.e. even in absence of
						// the evicted pod. For example, one can prevent all voluntary evictions
						// by specifying 0. This is a mutually exclusive setting with "minAvailable".
						maxUnavailable?: matchN(>=1, [int, string]) & (int | string)

						// An eviction is allowed if at least "minAvailable" pods selected by
						// "selector" will still be available after the eviction, i.e. even in the
						// absence of the evicted pod. So for example you can prevent all voluntary
						// evictions by specifying "100%".
						minAvailable?: matchN(>=1, [int, string]) & (int | string)

						// replaces default labels selector generated by operator
						// it's useful when you need to create custom budget
						selectorLabels?: [string]: string

						// UnhealthyPodEvictionPolicy defines the criteria for when unhealthy pods
						//
						// Valid policies are IfHealthyBudget and AlwaysAllow.
						// If no policy is specified, the default behavior will be used,
						// which corresponds to the IfHealthyBudget policy.
						unhealthyPodEvictionPolicy?: "IfHealthyBudget" | "AlwaysAllow"
					}

					// PodMetadata configures Labels and Annotations which are propagated to the vmagent pods.
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

					// Port listen address
					port?: string

					// PreStopSleepSeconds defines the number of seconds to sleep in the preStop lifecycle hook.
					// It gives time for load balancers to remove the pod from rotation before the pod is terminated.
					// Defaults to 15 for applicable components. Set to 0 to disable.
					preStopSleepSeconds?: int32 & int

					// PriorityClassName class assigned to the Pods
					priorityClassName?: string

					// ReadinessGates defines pod readiness gates
					readinessGates?: [...{
						// ConditionType refers to a condition in the pod's condition list with matching type.
						conditionType!: string
					}]

					// ReadinessProbe that will be added to CR pod
					readinessProbe?: {
						...
					}

					// RemoteWriteSettings defines global settings for all remoteWrite urls.
					remoteWriteSettings?: {
						// Interval for flushing the data to remote storage. (default 1s)
						flushInterval?: =~"[0-9]+(ms|s|m|h)"

						// Labels in the form 'name=value' to add to all the metrics before sending
						// them. This overrides the label if it already exists.
						label?: [string]: string

						// The maximum size in bytes of unpacked request to send to remote storage
						maxBlockSize?: int32 & int

						// The maximum file-based buffer size in bytes at -remoteWrite.tmpDataPath
						maxDiskUsagePerURL?: null | bool | number | string | [...] | {
							...
						}

						// The number of concurrent queues
						queues?: int32 & int

						// Whether to show -remoteWrite.url in the exported metrics. It is hidden by
						// default, since it can contain sensitive auth info
						showURL?: bool

						// Path to directory where temporary data for remote write component is stored
						// (default vmagent-remotewrite-data)
						tmpDataPath?: string

						// Configures vmagent accepting data via the same multitenant endpoints as
						// vminsert at VictoriaMetrics cluster does,
						// see [here](https://docs.victoriametrics.com/victoriametrics/vmagent/#multitenancy).
						// it's global setting and affects all remote storage configurations
						useMultiTenantMode?: bool
					}

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

					// The number of old ReplicaSets to retain to allow rollback in deployment or
					// maximum number of revisions that will be maintained in the Deployment revision history.
					// Has no effect at StatefulSets
					// Defaults to 10.
					revisionHistoryLimitCount?: int32 & int

					// RollingUpdate - overrides deployment update params.
					rollingUpdate?: {
						// The maximum number of pods that can be scheduled above the desired number of
						// pods.
						// Value can be an absolute number (ex: 5) or a percentage of desired pods (ex: 10%).
						// This can not be 0 if MaxUnavailable is 0.
						// Absolute number is calculated from percentage by rounding up.
						// Defaults to 25%.
						// Example: when this is set to 30%, the new ReplicaSet can be scaled up immediately when
						// the rolling update starts, such that the total number of old and new pods do not exceed
						// 130% of desired pods. Once old pods have been killed,
						// new ReplicaSet can be scaled up further, ensuring that total number of pods running
						// at any time during the update is at most 130% of desired pods.
						maxSurge?: matchN(>=1, [int, string]) & (int | string)

						// The maximum number of pods that can be unavailable during the update.
						// Value can be an absolute number (ex: 5) or a percentage of desired pods (ex: 10%).
						// Absolute number is calculated from percentage by rounding down.
						// This can not be 0 if MaxSurge is 0.
						// Defaults to 25%.
						// Example: when this is set to 30%, the old ReplicaSet can be scaled down to 70% of desired pods
						// immediately when the rolling update starts. Once new pods are ready, old ReplicaSet
						// can be scaled down further, followed by scaling up the new ReplicaSet, ensuring
						// that the total number of pods available at all times during the update is at
						// least 70% of desired pods.
						maxUnavailable?: matchN(>=1, [int, string]) & (int | string)
					}

					// RuntimeClassName - defines runtime class for kubernetes pod.
					// https://kubernetes.io/docs/concepts/containers/runtime-class/
					runtimeClassName?: string

					// SchedulerName - defines kubernetes scheduler name
					schedulerName?: string

					// Secrets is a list of Secrets in the same namespace as the Application
					// object, which shall be mounted into the Application container
					// at /etc/vm/secrets/SECRET_NAME folder
					secrets?: [...string]

					// SecurityContext holds pod-level security attributes and common container settings.
					// This defaults to the default PodSecurityContext.
					securityContext?: {
						...
					}

					// ServiceAccountName is the name of the ServiceAccount to use to run the pods
					serviceAccountName?: string

					// StartupProbe that will be added to CR pod
					startupProbe?: {
						...
					}

					// StatefulMode enables StatefulSet for `VMAgent` instead of Deployment
					// it allows using persistent storage for vmagent's persistentQueue
					statefulMode?: bool

					// StatefulRollingUpdateStrategy allows configuration for strategyType
					// set it to RollingUpdate for disabling operator statefulSet rollingUpdate
					statefulRollingUpdateStrategy?: string

					// StatefulRollingUpdateStrategyBehavior defines customized behavior for rolling updates.
					// It applies if the RollingUpdateStrategy is set to OnDelete, which is the default.
					statefulRollingUpdateStrategyBehavior?: {
						// MaxUnavailable defines the maximum number of pods that can be unavailable during the update.
						// It can be specified as an absolute number (e.g. 2) or a percentage of the
						// total pods (e.g. "50%").
						// For example, if set to 100%, all pods will be upgraded at once, minimizing downtime when needed.
						maxUnavailable?: matchN(>=1, [int, string]) & (int | string)
					}

					// StatefulStorage configures storage for StatefulSet
					statefulStorage?: {
						// EmptyDirVolumeSource to be used by the Prometheus StatefulSets. If specified,
						// used in place of any volumeClaimTemplate. More
						// info: https://kubernetes.io/docs/concepts/storage/volumes/#emptydir
						emptyDir?: {
							// medium represents what type of storage medium should back this directory.
							// The default is "" which means to use the node's default medium.
							// Must be an empty string (default) or Memory.
							// More info: https://kubernetes.io/docs/concepts/storage/volumes#emptydir
							medium?: string

							// mode specifies the permission bits for the emptyDir directory, in numeric
							// notation (e.g., 0755, 01777). Must be a value between 0000 and 01777.
							// If not specified, defaults to 0777.
							// This might be in conflict with other options that affect the file
							// mode, like fsGroup. If fsGroup is specified, the fsGroup permissions
							// will override the mode specified here.
							// This field has no effect on Windows.
							// This field is alpha and requires EmptyDirVolumeMode featuregate to be enabled.
							mode?: int32 & int

							// sizeLimit is the total amount of local storage required for this EmptyDir volume.
							// The size limit is also applicable for memory medium.
							// The maximum usage on memory medium EmptyDir would be the minimum value between
							// the SizeLimit specified here and the sum of memory limits of all containers in a pod.
							// The default is nil which means that the limit is undefined.
							// More info: https://kubernetes.io/docs/concepts/storage/volumes#emptydir
							sizeLimit?: matchN(>=1, [int, string]) & (int | =~"^(\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))(([KMGTPE]i)|[numkMGTPE]|([eE](\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))))?$")
						}

						// A PVC spec to be used by the StatefulSets/Deployments.
						volumeClaimTemplate?: {
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

							// EmbeddedMetadata contains metadata relevant to an EmbeddedResource.
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

							// Spec defines the desired characteristics of a volume requested by a pod author.
							// More info: https://kubernetes.io/docs/concepts/storage/persistent-volumes#persistentvolumeclaims
							spec?: {
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

							// Status represents the current information/status of a persistent volume claim.
							// Read-only.
							// More info: https://kubernetes.io/docs/concepts/storage/persistent-volumes#persistentvolumeclaims
							status?: {
								// accessModes contains the actual access modes the volume backing the PVC has.
								// More info: https://kubernetes.io/docs/concepts/storage/persistent-volumes#access-modes-1
								accessModes?: [...string]

								// allocatedResourceStatuses stores status of resource being resized for the given PVC.
								// Key names follow standard Kubernetes label syntax. Valid values are either:
								// * Un-prefixed keys:
								// - storage - the capacity of the volume.
								// * Custom resources must use implementation-defined prefixed names such as
								// "example.com/my-custom-resource"
								// Apart from above values - keys that are unprefixed or have kubernetes.io prefix are considered
								// reserved and hence may not be used.
								//
								// ClaimResourceStatus can be in any of following states:
								// - ControllerResizeInProgress:
								// State set when resize controller starts resizing the volume in control-plane.
								// - ControllerResizeFailed:
								// State set when resize has failed in resize controller with a terminal error.
								// - NodeResizePending:
								// State set when resize controller has finished resizing the volume but further resizing of
								// volume is needed on the node.
								// - NodeResizeInProgress:
								// State set when kubelet starts resizing the volume.
								// - NodeResizeFailed:
								// State set when resizing has failed in kubelet with a terminal error. Transient errors don't set
								// NodeResizeFailed.
								// For example: if expanding a PVC for more capacity - this field can be one of
								// the following states:
								// - pvc.status.allocatedResourceStatus['storage'] = "ControllerResizeInProgress"
								// - pvc.status.allocatedResourceStatus['storage'] = "ControllerResizeFailed"
								// - pvc.status.allocatedResourceStatus['storage'] = "NodeResizePending"
								// - pvc.status.allocatedResourceStatus['storage'] = "NodeResizeInProgress"
								// - pvc.status.allocatedResourceStatus['storage'] = "NodeResizeFailed"
								// When this field is not set, it means that no resize operation is in progress for the given PVC.
								//
								// A controller that receives PVC update with previously unknown resourceName or ClaimResourceStatus
								// should ignore the update for the purpose it was designed. For example - a controller that
								// only is responsible for resizing capacity of the volume, should ignore PVC
								// updates that change other valid
								// resources associated with PVC.
								allocatedResourceStatuses?: [string]: string

								// allocatedResources tracks the resources allocated to a PVC including its capacity.
								// Key names follow standard Kubernetes label syntax. Valid values are either:
								// * Un-prefixed keys:
								// - storage - the capacity of the volume.
								// * Custom resources must use implementation-defined prefixed names such as
								// "example.com/my-custom-resource"
								// Apart from above values - keys that are unprefixed or have kubernetes.io prefix are considered
								// reserved and hence may not be used.
								//
								// Capacity reported here may be larger than the actual capacity when a volume expansion operation
								// is requested.
								// For storage quota, the larger value from allocatedResources and PVC.spec.resources is used.
								// If allocatedResources is not set, PVC.spec.resources alone is used for quota calculation.
								// If a volume expansion capacity request is lowered, allocatedResources is only
								// lowered if there are no expansion operations in progress and if the actual volume capacity
								// is equal or lower than the requested capacity.
								//
								// A controller that receives PVC update with previously unknown resourceName
								// should ignore the update for the purpose it was designed. For example - a controller that
								// only is responsible for resizing capacity of the volume, should ignore PVC
								// updates that change other valid
								// resources associated with PVC.
								allocatedResources?: [string]: matchN(>=1, [int, string]) & (int | =~"^(\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))(([KMGTPE]i)|[numkMGTPE]|([eE](\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))))?$")

								// capacity represents the actual resources of the underlying volume.
								capacity?: [string]: matchN(>=1, [int, string]) & (int | =~"^(\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))(([KMGTPE]i)|[numkMGTPE]|([eE](\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))))?$")

								// conditions is the current Condition of persistent volume claim. If underlying
								// persistent volume is being
								// resized then the Condition will be set to 'Resizing'.
								conditions?: [...{
									// lastProbeTime is the time we probed the condition.
									lastProbeTime?: time.Time

									// lastTransitionTime is the time the condition transitioned from one status to another.
									lastTransitionTime?: time.Time

									// message is the human-readable message indicating details about last transition.
									message?: string

									// reason is a unique, this should be a short, machine understandable string that gives the reason
									// for condition's last transition. If it reports "Resizing" that means the underlying
									// persistent volume is being resized.
									reason?: string

									// Status is the status of the condition.
									// Can be True, False, Unknown.
									// More info:
									// https://kubernetes.io/docs/reference/kubernetes-api/config-and-storage-resources/persistent-volume-claim-v1/#:~:text=state%20of%20pvc-,conditions.status,-(string)%2C%20required
									status!: string

									// Type is the type of the condition.
									// More info:
									// https://kubernetes.io/docs/reference/kubernetes-api/config-and-storage-resources/persistent-volume-claim-v1/#:~:text=set%20to%20%27ResizeStarted%27.-,PersistentVolumeClaimCondition,-contains%20details%20about
									type!: string
								}]

								// currentVolumeAttributesClassName is the current name of the
								// VolumeAttributesClass the PVC is using.
								// When unset, there is no VolumeAttributeClass applied to this PersistentVolumeClaim
								currentVolumeAttributesClassName?: string

								// healthStatus contains the latest controller-reported health information
								// for the volume bound to this claim.
								healthStatus?: {
									// conditions is the set of adverse conditions reported by
									// the CSI controller plugin. An empty list means no adverse condition.
									// At most 16 conditions may be reported.
									healthConditions?: [...{
										// message is a human-readable description.
										// Maximum permitted length of a message is 1024 bytes.
										message?: string

										// reason is a brief CamelCase machine-parseable reason.
										// Together with status it forms the unique identity of a condition entry.
										// Maximum permitted length of a reason is 256 bytes.
										reason!: string

										// status is the machine-parseable health category.
										// Possible values:
										// - "Inaccessible": the volume cannot be accessed.
										// - "DataLoss": data loss has been detected on the volume.
										// - "Degraded": the volume is functioning with reduced capability.
										status!: "DataLoss" | "Degraded" | "Inaccessible"
									}]

									// lastTransitionTime is when the current set of conditions first appeared.
									lastTransitionTime?: time.Time
								}

								// ModifyVolumeStatus represents the status object of ControllerModifyVolume operation.
								// When this is unset, there is no ModifyVolume operation being attempted.
								modifyVolumeStatus?: {
									// status is the status of the ControllerModifyVolume operation. It can be in
									// any of following states:
									// - Pending
									// Pending indicates that the PersistentVolumeClaim cannot be modified due to
									// unmet requirements, such as
									// the specified VolumeAttributesClass not existing.
									// - InProgress
									// InProgress indicates that the volume is being modified.
									// - Infeasible
									// Infeasible indicates that the request has been rejected as invalid by the CSI driver. To
									// resolve the error, a valid VolumeAttributesClass needs to be specified.
									// Note: New statuses can be added in the future. Consumers should check for
									// unknown statuses and fail appropriately.
									status!: string

									// targetVolumeAttributesClassName is the name of the VolumeAttributesClass the
									// PVC currently being reconciled
									targetVolumeAttributesClassName?: string
								}

								// phase represents the current phase of PersistentVolumeClaim.
								phase?: string
							}
						}
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

					// UpdateStrategy - overrides default update strategy.
					// works only for deployments, statefulset always use OnDelete.
					updateStrategy?: "Recreate" | "RollingUpdate"

					// UseDefaultResources controls resource settings
					// By default, operator sets built-in resource requirements
					useDefaultResources?: bool

					// UseStrictSecurity enables strict security mode for component
					// it restricts disk writes access
					// uses non-root user out of the box
					// drops not needed security permissions
					useStrictSecurity?: bool

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
				}
			}

			// VMCluster defines a new inline or referencing existing one VMCluster.
			// Mutually exclusive with VMSingle in the same zone.
			vmcluster?: {
				// Name specifies the static name to be used for the new VMCluster.
				name?: string

				// Spec defines the desired state of a new or update spec for existing VMCluster.
				spec?: null | bool | number | string | [...] | {
					...
				}
			}

			// VMSingle defines a new inline or referencing existing one VMSingle.
			// Mutually exclusive with VMCluster in the same zone.
			vmsingle?: {
				// Name specifies the static name to be used for the new VMSingle.
				name?: string

				// Spec defines the desired state of a new or update spec for existing VMSingle.
				spec?: null | bool | number | string | [...] | {
					...
				}
			}
		}]
	}

	// status defines the observed state of VMDistributed
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
	apiVersion: "operator.victoriametrics.com/v1alpha1"
	kind:       "VMDistributed"
	metadata!: {
		name!:      string
		namespace!: string
		labels?: [string]: string
		annotations?: [string]: string
		...
	}
}
