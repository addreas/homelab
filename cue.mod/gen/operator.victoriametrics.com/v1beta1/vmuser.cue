package v1beta1

import (
	"time"
	"strings"
)

#VMUser: {
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

	// VMUserSpec defines the desired state of VMUser
	spec?: {
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

		// BearerToken Authorization header value for accessing protected endpoint.
		bearerToken?: string

		// DefaultURLs backend url for non-matching paths filter
		// usually used for default backend with error message
		default_url?: [...string]

		// DisableSecretCreation skips related secret creation for vmuser
		disable_secret_creation?: bool

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

		// GeneratePassword instructs operator to generate password for user
		// if spec.password if empty.
		generatePassword?: bool

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

		// JWT defines JWT based auth for a user
		jwt?: {
			// DefaultVMAccessClaim defines vm_access claim parameters to use when a JWT
			// doesn't carry a vm_access claim of its own. Set to an empty object to opt in
			// a token that only needs to pass matchClaims/oidc verification without vm_access.
			defaultVMAccessClaim?: {
				// LogsAccountID defines accountID to use for logs requests templating
				logsAccountID?: int32 & int

				// LogsExtraFilters defines a list of logsql filters to apply for logs requests templating
				logsExtraFilters?: [...string]

				// LogsExtraStreamFilters defines a list of logsql stream filters to apply for
				// logs requests templating
				logsExtraStreamFilters?: [...string]

				// LogsProjectID defines projectID to use for logs requests templating
				logsProjectID?: int32 & int

				// MetricsAccountID defines accountID to use for metrics requests templating
				metricsAccountID?: int32 & int

				// MetricsExtraFilters defines a list of promql filters to apply for metrics requests templating
				metricsExtraFilters?: [...string]

				// MetricsExtraLabels defines a list of extra labels to apply for metrics requests templating
				metricsExtraLabels?: [...string]

				// MetricsProjectID defines projectID to use for metrics requests templating
				metricsProjectID?: int32 & int
			}

			// MatchClaims enables claim based routing
			matchClaims?: [string]: string

			// OIDC defines OIDC configuration section
			oidc?: {
				// Issuer defines issuer URL for OIDC
				issuer!: string
			}

			// PublicKeyRefs defines a list of Secret selectors that reference public keys
			publicKeyRefs?: [...{
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
			}]

			// PublicKeys defines a list of public keys that are used for signature verification
			publicKeys?: [...string]

			// SkipVerify skips signature verification for testing purposes
			skipVerify?: bool
		}

		// LoadBalancingPolicy defines load balancing policy to use for backend urls.
		// Supported policies: least_loaded, first_available.
		// See
		// [here](https://docs.victoriametrics.com/victoriametrics/vmauth/#load-balancing)
		// for more details (default "least_loaded")
		load_balancing_policy?: "least_loaded" | "first_available"

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

		// MaxConcurrentRequests defines max concurrent requests per user
		// 300 is default value for vmauth
		max_concurrent_requests?: int

		// MetricLabels - additional labels for metrics exported by vmauth for given user.
		metric_labels?: [string]: string

		// Name of the VMUser object.
		name?: string

		// Password basic auth password for accessing protected endpoint.
		password?: string

		// PasswordRef allows fetching password from user-create secret by its name and key.
		passwordRef?: {
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
		targetRefs!: [...{
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

		// TokenRef allows fetching token from user-created secrets by its name and key.
		tokenRef?: {
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

		// UseLegacyNaming uses standalone Helm chart naming for managed resources:
		// the CR name is used directly instead of the default "<type>-<name>" convention.
		useLegacyNaming?: bool

		// Username basic auth user name for accessing protected endpoint,
		// will be replaced with metadata.name of VMUser if omitted.
		username?: string
	}

	// VMUserStatus defines the observed state of VMUser
	//
	// `updateStatus` is set to `operational` unless the operator cannot parse the spec,
	// in which case it is set to `failed`. It never reports whether the applications
	// selecting this object accepted its content - `conditions` carries that.
	// See https://github.com/VictoriaMetrics/operator/issues/2649
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
	kind:       "VMUser"
	metadata!: {
		name!:      string
		namespace!: string
		labels?: [string]: string
		annotations?: [string]: string
		...
	}
}
