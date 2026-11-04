package v1beta1

import (
	"strings"
	"time"
)

#GrafanaAlertRuleGroup: {
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

	// GrafanaAlertRuleGroupSpec defines the desired state of GrafanaAlertRuleGroup
	spec!: {
		// Allow the Operator to match this resource with Grafanas outside the current namespace
		allowCrossNamespaceImport?: bool

		// Whether to enable or disable editing of the alert rule group in Grafana UI
		editable?: bool

		// Match GrafanaFolders CRs to infer the uid
		folderRef?: string

		// UID of the folder containing this rule group
		// Overrides the FolderSelector
		folderUID?: string

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
		interval!: =~"^([0-9]+(\\.[0-9]+)?(ns|us|µs|ms|s|m|h))+$"

		// Name of the alert rule group. If not specified, the resource name will be used.
		name?: string

		// How often the resource is synced, defaults to 10m0s if not set
		resyncPeriod?: =~"^([0-9]+(\\.[0-9]+)?(ns|us|µs|ms|s|m|h))+$"
		rules!: [...{
			annotations?: [string]: string
			condition!: string

			// Deprecated: The field is not used, use rules[].annotations.__dashboardUid__
			dashboardUid?: string
			data!: [...{
				// Grafana data source unique identifier; it should be '__expr__' for a Server
				// Side Expression operation.
				datasourceUid?: string

				// JSON is the raw JSON query and includes the above properties as well as custom properties.
				model?: null | bool | number | string | [...] | {
					...
				}

				// QueryType is an optional identifier for the type of query.
				// It can be used to distinguish different types of queries.
				queryType?: string

				// RefID is the unique identifier of the query, set by the frontend call.
				refId?: string

				// relative time range
				relativeTimeRange?: {
					// from
					from?: int64 & int

					// to
					to?: int64 & int
				}
			}]
			execErrState!:  "OK" | "Alerting" | "Error" | "KeepLast"
			for!:           =~"^([0-9]+(\\.[0-9]+)?(s|m|h|d|w))+$"
			isPaused?:      bool
			keepFiringFor?: =~"^([0-9]+(\\.[0-9]+)?(ns|us|µs|ms|s|m|h))+$"
			labels?: [string]: string

			// The number of missing series evaluations that must occur before the rule is
			// considered to be resolved.
			missingSeriesEvalsToResolve?: int64 & int
			noDataState!:                 "Alerting" | "NoData" | "OK" | "KeepLast"
			notificationSettings?: {
				// ActiveTimeIntervals defines the time intervals during which notifications should NOT be muted.
				active_time_intervals?: [...string]

				// GroupBy defines the labels by which incoming alerts are grouped together.
				group_by?: [...string]

				// GroupInterval defines how long to wait before sending a notification about new alerts added
				// to a group for which an initial notification has already been sent. (e.g. 5m)
				group_interval?: string

				// GroupWait defines how long to initially wait to send a notification for a
				// group of alerts. (e.g. 30s)
				group_wait?: string

				// MuteTimeIntervals defines the time intervals during which notifications should be muted.
				// These must match the name of a mute time interval defined in the Alertmanager configuration.
				mute_time_intervals?: [...string]

				// Receiver is the name of the receiver to send notifications to.
				receiver!: strings.MinRunes(
						1)

				// RepeatInterval defines how long to wait before sending a notification again if it has already
				// been sent successfully for an alert. (e.g. 4h)
				// Should not be less than GroupInterval.
				repeat_interval?: string
			}

			// Deprecated: The field is not used, use rules[].annotations.__panelId__
			panelId?: int
			record?: {
				from!:                string
				metric!:              string
				targetDatasourceUid?: string
			}
			title!: strings.MaxRunes(
				190) & strings.MinRunes(
				1)

			// UID of the alert rule. Can be any string consisting of alphanumeric
			// characters, - and _ with a maximum length of 40
			uid!: strings.MaxRunes(
				40) & =~"^[a-zA-Z0-9-_]+$"
		}] & [_, ...]

		// Suspend pauses synchronizing attempts and tells the operator to ignore changes
		suspend?: bool
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
	kind:       "GrafanaAlertRuleGroup"
	metadata!: {
		name!:      string
		namespace!: string
		labels?: [string]: string
		annotations?: [string]: string
		...
	}
}
