package v1beta1

import (
	"strings"
	"list"
	"time"
)

#GrafanaDatasource: {
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

	// GrafanaDatasourceSpec defines the desired state of GrafanaDatasource
	spec!: {
		// Allow the Operator to match this resource with Grafanas outside the current namespace
		allowCrossNamespaceImport?: bool
		datasource!: {
			access?:        string
			basicAuth?:     bool
			basicAuthUser?: string
			database?:      string

			// Whether to enable/disable editing of the datasource in Grafana UI
			editable?:  bool
			isDefault?: bool
			jsonData?: {
				...
			}
			name?: string

			// Deprecated field, it has no effect
			orgId?: int64 & int
			secureJsonData?: {
				...
			}
			type?: string

			// Deprecated field, use spec.uid instead
			uid?:  string
			url?:  string
			user?: string
		}

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

		// plugins
		plugins?: [...{
			name!:    strings.MinRunes(
					1)
			version!: =~"^((0|[1-9]\\d*)\\.(0|[1-9]\\d*)\\.(0|[1-9]\\d*)(?:-((?:0|[1-9]\\d*|\\d*[a-zA-Z-][0-9a-zA-Z-]*)(?:\\.(?:0|[1-9]\\d*|\\d*[a-zA-Z-][0-9a-zA-Z-]*))*))?(?:\\+([0-9a-zA-Z-]+(?:\\.[0-9a-zA-Z-]+)*))?|latest)$"
		}]

		// How often the resource is synced, defaults to 10m0s if not set
		resyncPeriod?: =~"^([0-9]+(\\.[0-9]+)?(ns|us|µs|ms|s|m|h))+$"

		// Suspend pauses synchronizing attempts and tells the operator to ignore changes
		suspend?: bool

		// The UID, for the datasource, fallback to the deprecated spec.datasource.uid
		// and metadata.uid. Can be any string consisting of alphanumeric characters,
		// - and _ with a maximum length of 40 +optional
		uid?: strings.MaxRunes(
			40) & =~"^[a-zA-Z0-9-_]+$"

		// environments variables from secrets or config maps
		valuesFrom?: list.MaxItems(99) & [...{
			targetPath!: string
			valueFrom!: {
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
	}

	// GrafanaDatasourceStatus defines the observed state of GrafanaDatasource
	status?: {
		// The datasource instanceSelector can't find matching grafana instances
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
		hash?: string

		// Deprecated: Check status.conditions or operator logs
		lastMessage?: string

		// Last time the resource was synchronized with Grafana instances
		lastResync?: time.Time
		uid?:        string
	}

	_embeddedResource: {
		apiVersion!: string
		kind!:       string
		metadata?: {
			...
		}
	}
	apiVersion: "grafana.integreatly.org/v1beta1"
	kind:       "GrafanaDatasource"
	metadata!: {
		name!:      string
		namespace!: string
		labels?: [string]: string
		annotations?: [string]: string
		...
	}
}
