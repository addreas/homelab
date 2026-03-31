package v1beta1

import (
	"list"
	"strings"
)

#ReferenceGrant: {
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

	// Spec defines the desired state of ReferenceGrant.
	spec?: {
		// From describes the trusted namespaces and kinds that can
		// reference the
		// resources described in "To". Each entry in this list MUST be
		// considered
		// to be an additional place that references can be valid from, or
		// to put
		// this another way, entries MUST be combined using OR.
		//
		// Support: Core
		from!: list.MaxItems(16) & [...{
			// Group is the group of the referent.
			// When empty, the Kubernetes core API group is inferred.
			//
			// Support: Core
			group!: strings.MaxRunes(
				253) & =~"^$|^[a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*$"

			// Kind is the kind of the referent. Although implementations may
			// support
			// additional resources, the following types are part of the
			// "Core"
			// support level for this field.
			//
			// When used to permit a SecretObjectReference:
			//
			// * Gateway
			//
			// When used to permit a BackendObjectReference:
			//
			// * GRPCRoute
			// * HTTPRoute
			// * TCPRoute
			// * TLSRoute
			// * UDPRoute
			kind!: strings.MaxRunes(
				63) & strings.MinRunes(
				1) & =~"^[a-zA-Z]([-a-zA-Z0-9]*[a-zA-Z0-9])?$"

			// Namespace is the namespace of the referent.
			//
			// Support: Core
			namespace!: strings.MaxRunes(
					63) & strings.MinRunes(
					1) & =~"^[a-z0-9]([-a-z0-9]*[a-z0-9])?$"
		}] & [_, ...]

		// To describes the resources that may be referenced by the
		// resources
		// described in "From". Each entry in this list MUST be considered
		// to be an
		// additional place that references can be valid to, or to put
		// this another
		// way, entries MUST be combined using OR.
		//
		// Support: Core
		to!: list.MaxItems(16) & [...{
			// Group is the group of the referent.
			// When empty, the Kubernetes core API group is inferred.
			//
			// Support: Core
			group!: strings.MaxRunes(
				253) & =~"^$|^[a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*$"

			// Kind is the kind of the referent. Although implementations may
			// support
			// additional resources, the following types are part of the
			// "Core"
			// support level for this field:
			//
			// * Secret when used to permit a SecretObjectReference
			// * Service when used to permit a BackendObjectReference
			kind!: strings.MaxRunes(
				63) & strings.MinRunes(
				1) & =~"^[a-zA-Z]([-a-zA-Z0-9]*[a-zA-Z0-9])?$"

			// Name is the name of the referent. When unspecified, this policy
			// refers to all resources of the specified Group and Kind in the
			// local
			// namespace.
			name?: strings.MaxRunes(
				253) & strings.MinRunes(
				1)
		}] & [_, ...]
	}

	_embeddedResource: {
		apiVersion!: string
		kind!:       string
		metadata?: {
			...
		}
	}
	apiVersion: "gateway.networking.k8s.io/v1beta1"
	kind:       "ReferenceGrant"
	metadata!: {
		name!:      string
		namespace!: string
		labels?: [string]: string
		annotations?: [string]: string
		...
	}
}
