package v1

import (
	"strings"
	"list"
	"time"
)

#GatewayClass: {
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
	metadata?: {}

	// Spec defines the desired state of GatewayClass.
	spec!: {
		// ControllerName is the name of the controller that is managing
		// Gateways of
		// this class. The value of this field MUST be a domain prefixed
		// path.
		//
		// Example: "example.net/gateway-controller".
		//
		// This field is not mutable and cannot be empty.
		//
		// Support: Core
		controllerName!: strings.MaxRunes(
					253) & strings.MinRunes(
					1) & =~"^[a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*\\/[A-Za-z0-9\\/\\-._~%!$&'()*+,;=:]+$"

		// Description helps describe a GatewayClass with more details.
		description?: strings.MaxRunes(
				64)

		// ParametersRef is a reference to a resource that contains the
		// configuration
		// parameters corresponding to the GatewayClass. This is optional
		// if the
		// controller does not require any additional configuration.
		//
		// ParametersRef can reference a standard Kubernetes resource,
		// i.e. ConfigMap,
		// or an implementation-specific custom resource. The resource can
		// be
		// cluster-scoped or namespace-scoped.
		//
		// If the referent cannot be found, refers to an unsupported kind,
		// or when
		// the data within that resource is malformed, the GatewayClass
		// SHOULD be
		// rejected with the "Accepted" status condition set to "False"
		// and an
		// "InvalidParameters" reason.
		//
		// A Gateway for this GatewayClass may provide its own
		// `parametersRef`. When both are specified,
		// the merging behavior is implementation specific.
		// It is generally recommended that GatewayClass provides defaults
		// that can be overridden by a Gateway.
		//
		// Support: Implementation-specific
		parametersRef?: {
			// Group is the group of the referent.
			group!: strings.MaxRunes(
				253) & =~"^$|^[a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*$"

			// Kind is kind of the referent.
			kind!: strings.MaxRunes(
				63) & strings.MinRunes(
				1) & =~"^[a-zA-Z]([-a-zA-Z0-9]*[a-zA-Z0-9])?$"

			// Name is the name of the referent.
			name!: strings.MaxRunes(
				253) & strings.MinRunes(
				1)

			// Namespace is the namespace of the referent.
			// This field is required when referring to a Namespace-scoped
			// resource and
			// MUST be unset when referring to a Cluster-scoped resource.
			namespace?: strings.MaxRunes(
					63) & strings.MinRunes(
					1) & =~"^[a-z0-9]([-a-z0-9]*[a-z0-9])?$"
		}
	}

	// Status defines the current state of GatewayClass.
	//
	// Implementations MUST populate status on all GatewayClass
	// resources which
	// specify their controller name.
	status?: {
		// Conditions is the current status from the controller for
		// this GatewayClass.
		//
		// Controllers should prefer to publish conditions using values
		// of GatewayClassConditionType for the type of each Condition.
		conditions?: list.MaxItems(8) & [...{
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

		// SupportedFeatures is the set of features the GatewayClass
		// support.
		// It MUST be sorted in ascending alphabetical order by the Name
		// key.
		supportedFeatures?: list.MaxItems(64) & [...{
			// FeatureName is used to describe distinct features that are
			// covered by
			// conformance tests.
			name!: string
		}]
	}

	_embeddedResource: {
		apiVersion!: string
		kind!:       string
		metadata?: {
			...
		}
	}
	apiVersion: "gateway.networking.k8s.io/v1"
	kind:       "GatewayClass"
	metadata!: {
		name!:      string
		namespace?: string
		labels?: [string]: string
		annotations?: [string]: string
		...
	}
}
