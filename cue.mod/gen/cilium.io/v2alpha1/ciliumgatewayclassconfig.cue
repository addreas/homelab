package v2alpha1

import (
	"strings"
	"time"
)

#CiliumGatewayClassConfig: {
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

	// Spec is a human-readable of a GatewayClass configuration.
	spec?: {
		// Description helps describe a GatewayClass configuration with
		// more details.
		description?: strings.MaxRunes(
				64)

		// Service specifies the configuration for the generated Service.
		// Note that not all fields from upstream Service.Spec are
		// supported
		service?: {
			// Sets the Service.Spec.AllocateLoadBalancerNodePorts in
			// generated Service objects to the given value.
			allocateLoadBalancerNodePorts?: bool

			// Sets the Service.Spec.ExternalTrafficPolicy in generated
			// Service objects to the given value.
			externalTrafficPolicy?: string

			// Sets the Service.Spec.IPFamilies in generated Service objects
			// to the given value.
			ipFamilies?: [...string]

			// Sets the Service.Spec.IPFamilyPolicy in generated Service
			// objects to the given value.
			ipFamilyPolicy?: string

			// Sets the Service.Spec.LoadBalancerClass in generated Service
			// objects to the given value.
			loadBalancerClass?: string

			// Sets the Service.Spec.LoadBalancerSourceRanges in generated
			// Service objects to the given value.
			loadBalancerSourceRanges?: [...string]

			// LoadBalancerSourceRangesPolicy defines the policy for the
			// LoadBalancerSourceRanges if the incoming traffic
			// is allowed or denied.
			loadBalancerSourceRangesPolicy?: "Allow" | "Deny"

			// Sets the Service.Spec.TrafficDistribution in generated Service
			// objects to the given value.
			trafficDistribution?: string

			// Sets the Service.Spec.Type in generated Service objects to the
			// given value.
			// Only LoadBalancer and NodePort are supported.
			type?: "LoadBalancer" | "NodePort"
		}
	}

	// Status is the status of the policy.
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
	apiVersion: "cilium.io/v2alpha1"
	kind:       "CiliumGatewayClassConfig"
	metadata!: {
		name!:      string
		namespace!: string
		labels?: [string]: string
		annotations?: [string]: string
		...
	}
}
