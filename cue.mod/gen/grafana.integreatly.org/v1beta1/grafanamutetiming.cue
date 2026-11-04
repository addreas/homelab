package v1beta1

import (
	"time"
	"strings"
)

#GrafanaMuteTiming: {
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

	// GrafanaMuteTimingSpec defines the desired state of GrafanaMuteTiming
	spec!: {
		// Allow the Operator to match this resource with Grafanas outside the current namespace
		allowCrossNamespaceImport?: bool

		// Whether to enable or disable editing of the mute timing in Grafana UI
		editable?: bool

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

		// A unique name for the mute timing
		name!: string

		// How often the resource is synced, defaults to 10m0s if not set
		resyncPeriod?: =~"^([0-9]+(\\.[0-9]+)?(ns|us|µs|ms|s|m|h))+$"

		// Suspend pauses synchronizing attempts and tells the operator to ignore changes
		suspend?: bool

		// Time intervals for muting
		time_intervals!: [...{
			// The date 1-31 of a month. Negative values can also be used to represent days
			// that begin at the end of the month.
			// For example: -1 for the last day of the month.
			days_of_month?: [...string]

			// Depending on the location, the time range is displayed in local time.
			location?: string

			// The months of the year in either numerical or the full calendar month.
			// For example: 1, may.
			months?: [...string]

			// The time inclusive of the start and exclusive of the end time (in UTC if no
			// location has been selected, otherwise local time).
			times?: [...{
				// end time
				end_time!: string

				// start time
				start_time!: string
			}]

			// The day or range of days of the week.
			// For example: monday, thursday
			weekdays?: [...string]

			// The year or years for the interval.
			// For example: 2021
			years?: [...string]
		}] & [_, ...]
	}

	// The most recent observed state of a Grafana resource
	status?: {
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

		// Last time the resource was synchronized with Grafana instances
		lastResync?: time.Time
	}

	_embeddedResource: {
		apiVersion!: string
		kind!:       string
		metadata?: {
			...
		}
	}
	apiVersion: "grafana.integreatly.org/v1beta1"
	kind:       "GrafanaMuteTiming"
	metadata!: {
		name!:      string
		namespace!: string
		labels?: [string]: string
		annotations?: [string]: string
		...
	}
}
