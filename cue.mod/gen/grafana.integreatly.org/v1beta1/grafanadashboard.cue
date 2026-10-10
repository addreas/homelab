package v1beta1

import (
	"strings"
	"time"
)

#GrafanaDashboard: {
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

	// GrafanaDashboardSpec defines the desired state of GrafanaDashboard
	spec!: {
		// Allow the Operator to match this resource with Grafanas outside the current namespace
		allowCrossNamespaceImport?: bool

		// model from configmap
		configMapRef?: {
			// The key to select.
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

		// Cache duration for models fetched from URLs
		contentCacheDuration?: string

		// maps required data sources to existing ones
		datasources?: [...{
			datasourceName!: string
			inputName!:      string
		}]

		// environments variables from secrets or config maps
		envFrom?: [...{
			// Selects a key of a ConfigMap.
			configMapKeyRef?: {
				// The key to select.
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

			// Selects a key of a Secret.
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
		}]

		// environments variables as a map
		envs?: [...{
			name!: string

			// Inline env value
			value?: string

			// Reference on value source, might be the reference on a secret or config map
			valueFrom?: {
				// Selects a key of a ConfigMap.
				configMapKeyRef?: {
					// The key to select.
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

				// Selects a key of a Secret.
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

		// folder assignment for dashboard
		folder?: string

		// Name of a `GrafanaFolder` resource in the same namespace
		folderRef?: string

		// UID of the target folder for this dashboard
		folderUID?: string

		// grafana.com/dashboards
		grafanaCom?: {
			id!:       int
			revision?: int
		}

		// GzipJson the model's JSON compressed with Gzip. Base64-encoded when in YAML.
		gzipJson?: string

		// Selects Grafana instances for import
		instanceSelector!: {
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

		// model json
		json?: string

		// Jsonnet
		jsonnet?: string

		// Jsonnet project build
		jsonnetLib?: {
			fileName!:           string
			gzipJsonnetProject!: string
			jPath?: [...string]
		}

		// model from an OCI artifact (e.g. ghcr.io/team/dashboards:v1)
		oci?: {
			// InsecurePlainHTTP switches the registry connection to plain HTTP (non-TLS) instead of HTTPS.
			// Intended for in-cluster or test registries; HTTPS registries with self-signed
			// certificates are not supported. Default false.
			insecurePlainHTTP?: bool

			// Path is the path of the file to extract from the artifact.
			path!: strings.MaxRunes(
				512) & strings.MinRunes(
				1)

			// PullSecretRef references a kubernetes.io/dockerconfigjson Secret in the same namespace as the CR.
			// If omitted, anonymous pull is attempted.
			pullSecretRef?: {
				// Name of the referent.
				// This field is effectively required, but due to backwards compatibility is
				// allowed to be empty. Instances of this type with an empty value here are
				// almost certainly wrong.
				// More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names
				name?: string
			}

			// Reference is the full OCI artifact reference including a tag or digest,
			// e.g. "ghcr.io/team/dashboards:v1.4.7" or
			// "ghcr.io/team/dashboards@sha256:abc123...". Prefer a digest for
			// reproducible deployments.
			reference!: strings.MaxRunes(
					512) & strings.MinRunes(
					3) & =~"^[^:@]+(:[^:@/]+|@sha256:[a-fA-F0-9]{64})$"
		}

		// plugins
		plugins?: [...{
			name!:    strings.MinRunes(
					1)
			version!: =~"^((0|[1-9]\\d*)\\.(0|[1-9]\\d*)\\.(0|[1-9]\\d*)(?:-((?:0|[1-9]\\d*|\\d*[a-zA-Z-][0-9a-zA-Z-]*)(?:\\.(?:0|[1-9]\\d*|\\d*[a-zA-Z-][0-9a-zA-Z-]*))*))?(?:\\+([0-9a-zA-Z-]+(?:\\.[0-9a-zA-Z-]+)*))?|latest)$"
		}]

		// Allows configuration of sharing the dashboard publicly
		publicSharing?: {
			// Optional. Unique access token. If empty it will generate a new access token per instance.
			accessToken?: strings.MaxRunes(
					36) & strings.MinRunes(
					36)

			// Optional. When set to true, shows annotations. The default value is false.
			annotationsEnabled?: bool

			// Optional. Set to false to disable sharing, the public dashboard is still
			// created. The default value is true.
			enabled?: bool

			// Optional. when set to true, the time picker is enabled in the shared
			// dashboard. The default value is false.
			timeSelectionEnabled?: bool
		}

		// How often the resource is synced, defaults to 10m0s if not set
		resyncPeriod?: =~"^([0-9]+(\\.[0-9]+)?(ns|us|µs|ms|s|m|h))+$"

		// Suspend pauses synchronizing attempts and tells the operator to ignore changes
		suspend?: bool

		// Manually specify the uid, overwrites uids already present in the json model.
		// Can be any string consisting of alphanumeric characters, - and _ with a maximum length of 40.
		uid?: strings.MaxRunes(
			40) & =~"^[a-zA-Z0-9-_]+$"

		// model url
		url?: =~"^https?://.+$"

		// authorization options for model from url
		urlAuthorization?: basicAuth?: {
			// SecretKeySelector selects a key of a Secret.
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

			// SecretKeySelector selects a key of a Secret.
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

		// overrides the default (current) value of named template variables in the dashboard model.
		// Variables that are not present in the model are ignored.
		variables?: [...{
			// Name of the template variable to override, matching templating.list[].name in the model.
			name!: strings.MinRunes(
				1)

			// Value is the new default value. For datasource variables this is the datasource UID or
			// name; for query, custom, constant and textbox variables it is the selected value.
			// Multi-value (multi-select) variables are collapsed to this single value.
			value!: string
		}]
	}

	// GrafanaDashboardStatus defines the observed state of GrafanaDashboard
	status?: {
		// The dashboard instanceSelector can't find matching grafana instances
		NoMatchingInstances?: bool

		// Results when synchronizing resource with Grafana instances
		conditions?: [...{
			// lastTransitionTime is the last time the condition transitioned from one status to another.
			// This should be when the underlying condition changed. If that is not known,
			// then using the time when the API field changed is acceptable.
			lastTransitionTime!: time.Time

			// message is a human readable message indicating details about the transition.
			// This may be an empty string.
			message!: strings.MaxRunes(
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
					1) & =~"^[A-Za-z]([A-Za-z0-9_,:]*[A-Za-z0-9_])?$"

			// status of the condition, one of True, False, Unknown.
			status!: "True" | "False" | "Unknown"

			// type of condition in CamelCase or in foo.example.com/CamelCase.
			type!: strings.MaxRunes(
				316) & =~"^([a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*/)?(([A-Za-z0-9][-A-Za-z0-9_.]*)?[A-Za-z0-9])$"
		}]
		contentCache?:     string
		contentTimestamp?: time.Time
		contentUrl?:       string
		hash?:             string

		// Last time the resource was synchronized with Grafana instances
		lastResync?: time.Time

		// The resulting path where a public sharing config is available
		publicSharingPath?: string
		uid?:               string
	}

	_embeddedResource: {
		apiVersion!: string
		kind!:       string
		metadata?: {
			...
		}
	}
	apiVersion: "grafana.integreatly.org/v1beta1"
	kind:       "GrafanaDashboard"
	metadata!: {
		name!:      string
		namespace!: string
		labels?: [string]: string
		annotations?: [string]: string
		...
	}
}
