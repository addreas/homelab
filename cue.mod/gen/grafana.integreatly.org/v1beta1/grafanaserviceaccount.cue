package v1beta1

import (
	"strings"
	"time"
)

#GrafanaServiceAccount: {
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

	// GrafanaServiceAccountSpec defines the desired state of a GrafanaServiceAccount.
	spec?: {
		// Name of the Grafana instance to create the service account for
		instanceName!: strings.MinRunes(
				1)

		// Whether the service account is disabled
		isDisabled?: bool

		// Name of the service account in Grafana
		name?: strings.MinRunes(
			1)

		// How often the resource is synced, defaults to 10m0s if not set
		resyncPeriod?: =~"^([0-9]+(\\.[0-9]+)?(ns|us|µs|ms|s|m|h))+$"

		// Role of the service account (Viewer, Editor, Admin)
		role!: "Viewer" | "Editor" | "Admin"

		// Suspend pauses reconciliation of the service account
		suspend?: bool

		// Tokens to create for the service account
		tokens?: [...{
			// Expiration date of the token. If not set, the token never expires
			expires?: time.Time

			// Name of the token
			name!: strings.MinRunes(
				1)

			// Name of the secret to store the token. If not set, a name will be generated
			secretName?: strings.MinRunes(
					1)
		}]
	}

	// GrafanaServiceAccountStatus defines the observed state of a GrafanaServiceAccount
	status?: {
		// Info contains the Grafana service account information
		account?: {
			// ID of the service account in Grafana
			id!: int64 & int

			// IsDisabled indicates if the service account is disabled
			isDisabled!: bool
			login!:      string
			name!:       string

			// Role is the Grafana role for the service account (Viewer, Editor, Admin)
			role!: string

			// Information about tokens
			tokens?: [...{
				// Expiration time of the token
				// N.B. There's possible discrepancy with the expiration time in spec
				// It happens because Grafana API accepts TTL in seconds then calculates the
				// expiration time against the current time
				expires?: time.Time

				// ID of the token in Grafana
				id!:   int64 & int
				name!: string

				// Name of the secret containing the token
				secret?: {
					name?:      string
					namespace?: string
				}
			}]
		}

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
	kind:       "GrafanaServiceAccount"
	metadata!: {
		name!:      string
		namespace!: string
		labels?: [string]: string
		annotations?: [string]: string
		...
	}
}
