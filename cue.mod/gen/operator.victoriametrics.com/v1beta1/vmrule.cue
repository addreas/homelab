package v1beta1

import (
	"time"
	"strings"
)

#VMRule: {
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

	// VMRuleSpec defines the desired state of VMRule
	spec!: {
		// Groups list of group rules
		groups!: [...{
			// Concurrency defines how many rules execute at once.
			concurrency?: int

			// Optional
			// The evaluation timestamp will be aligned with group's interval,
			// instead of using the actual timestamp that evaluation happens at.
			// It is enabled by default to get more predictable results
			// and to visually align with graphs plotted via Grafana or vmui.
			eval_alignment?: bool

			// Optional
			// Adjust the `time` parameter of group evaluation requests to compensate
			// intentional query delay from the datasource.
			eval_delay?: string

			// Optional
			// Group will be evaluated at the exact offset in the range of [0...interval].
			eval_offset?: string

			// Headers contains optional HTTP headers added to each rule request
			// Must be in form `header-name: value`
			// For example:
			// headers:
			// - "CustomHeader: foo"
			// - "CustomHeader2: bar"
			headers?: [...string]

			// evaluation interval for group
			interval?: string

			// Labels optional list of labels added to every rule within a group.
			// It has priority over the external labels.
			// Labels are commonly used for adding environment
			// or tenant-specific tag.
			labels?: [string]: string

			// Limit the number of alerts an alerting rule and series a recording
			// rule can produce
			limit?: int

			// Name of group
			name!: string

			// NotifierHeaders contains optional HTTP headers added to each alert request
			// which will send to notifier
			// Must be in form `header-name: value`
			// For example:
			// headers:
			// - "CustomHeader: foo"
			// - "CustomHeader2: bar"
			notifier_headers?: [...string]

			// Params optional HTTP URL parameters added to each rule request
			params?: [string]: [...string]

			// Rules list of alert rules.
			rules!: [...{
				// Alert is a name for alert
				alert?: string

				// Annotations will be added to rule configuration
				annotations?: [string]: string

				// Debug enables logging for rule
				// it useful for tracking
				debug?: bool

				// Expr is query, that will be evaluated at dataSource
				expr?: string

				// For evaluation interval in time.Duration format
				// 30s, 1m, 1h or nanoseconds
				for?: string

				// KeepFiringFor will make alert continue firing for this long
				// even when the alerting expression no longer has results.
				// Use time.Duration format, 30s, 1m, 1h or nanoseconds
				keep_firing_for?: string

				// Labels will be added to rule configuration
				labels?: [string]: string

				// Record represents a query, that will be recorded to dataSource
				record?: string

				// UpdateEntriesLimit defines max number of rule's state updates stored in memory.
				// Overrides `-rule.updateEntriesLimit` in vmalert.
				update_entries_limit?: int
			}]

			// Tenant id for group, can be used only with enterprise version of vmalert.
			// See more details [here](https://docs.victoriametrics.com/victoriametrics/vmalert/#multitenancy).
			tenant?: string

			// Type defines datasource type for enterprise version of vmalert
			// possible values - prometheus,graphite,vlogs
			type?: string
		}]
	}

	// VMRuleStatus defines the observed state of VMRule
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
	kind:       "VMRule"
	metadata!: {
		name!:      string
		namespace!: string
		labels?: [string]: string
		annotations?: [string]: string
		...
	}
}
