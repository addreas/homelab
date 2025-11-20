package v2

import (
	"strings"
	"time"
)

#CiliumLoadBalancerIPPool: {
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

	// Spec is a human readable description for a BGP load balancer
	// ip pool.
	spec!: {
		// AllowFirstLastIPs, if set to `Yes` or undefined means that the
		// first and last IPs of each CIDR will be allocatable.
		// If `No`, these IPs will be reserved. This field is ignored for
		// /{31,32} and /{127,128} CIDRs since
		// reserving the first and last IPs would make the CIDRs unusable.
		allowFirstLastIPs?: "Yes" | "No"

		// Blocks is a list of CIDRs comprising this IP Pool
		blocks?: [...{
			cidr?:  string
			start?: string
			stop?:  string
		}]

		// Disabled, if set to true means that no new IPs will be
		// allocated from this pool.
		// Existing allocations will not be removed from services.
		disabled?: bool

		// ServiceSelector selects a set of services which are eligible to
		// receive IPs from this
		serviceSelector?: {
			// matchExpressions is a list of label selector requirements. The
			// requirements are ANDed.
			matchExpressions?: [...{
				// key is the label key that the selector applies to.
				key!: string

				// operator represents a key's relationship to a set of values.
				// Valid operators are In, NotIn, Exists and DoesNotExist.
				operator!: "In" | "NotIn" | "Exists" | "DoesNotExist"

				// values is an array of string values. If the operator is In or
				// NotIn,
				// the values array must be non-empty. If the operator is Exists
				// or DoesNotExist,
				// the values array must be empty. This array is replaced during a
				// strategic
				// merge patch.
				values?: [...string]
			}]

			// matchLabels is a map of {key,value} pairs. A single {key,value}
			// in the matchLabels
			// map is equivalent to an element of matchExpressions, whose key
			// field is "key", the
			// operator is "In", and the values array contains only "value".
			// The requirements are ANDed.
			matchLabels?: [string]: strings.MaxRunes(
						63) & =~"^(([A-Za-z0-9][-A-Za-z0-9_.]*)?[A-Za-z0-9])?$"
		}
	}

	// Status is the status of the IP Pool.
	//
	// It might be possible for users to define overlapping IP Pools,
	// we can't validate or enforce non-overlapping pools
	// during object creation. The Cilium operator will do this
	// validation and update the status to reflect the ability
	// to allocate IPs from this pool.
	status?: {
		// Current service state
		conditions?: [...{
			// lastTransitionTime is the last time the condition transitioned
			// from one status to another.
			// This should be when the underlying condition changed. If that
			// is not known, then using the time when the API field changed
			// is acceptable.
			lastTransitionTime!: time.Time

			// message is a human readable message indicating details about
			// the transition.
			// This may be an empty string.
			message!: strings.MaxRunes(
					32768)

			// observedGeneration represents the .metadata.generation that the
			// condition was set based upon.
			// For instance, if .metadata.generation is currently 12, but the
			// .status.conditions[x].observedGeneration is 9, the condition
			// is out of date
			// with respect to the current state of the instance.
			observedGeneration?: int64 & int & >=0

			// reason contains a programmatic identifier indicating the reason
			// for the condition's last transition.
			// Producers of specific condition types may define expected
			// values and meanings for this field,
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
	}

	_embeddedResource: {
		apiVersion!: string
		kind!:       string
		metadata?: {
			...
		}
	}
	apiVersion: "cilium.io/v2"
	kind:       "CiliumLoadBalancerIPPool"
	metadata!: {
		name!:      string
		namespace?: string
		labels?: [string]: string
		annotations?: [string]: string
		...
	}
}
