package v1

import (
	"list"
	"strings"
	"time"
)

#TLSRoute: {
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

	// Spec defines the desired state of TLSRoute.
	spec!: {
		// Hostnames defines a set of SNI hostnames that should match
		// against the
		// SNI attribute of TLS ClientHello message in TLS handshake. This
		// matches
		// the RFC 1123 definition of a hostname with 2 notable
		// exceptions:
		//
		// 1. IPs are not allowed in SNI hostnames per RFC 6066.
		// 2. A hostname may be prefixed with a wildcard label (`*.`). The
		// wildcard
		// label must appear by itself as the first label.
		hostnames!: list.MaxItems(16) & [...strings.MaxRunes(
			253) & strings.MinRunes(
			1) & =~"^(\\*\\.)?[a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*$"] & [_, ...]

		// ParentRefs references the resources (usually Gateways) that a
		// Route wants
		// to be attached to. Note that the referenced parent resource
		// needs to
		// allow this for the attachment to be complete. For Gateways,
		// that means
		// the Gateway needs to allow attachment from Routes of this kind
		// and
		// namespace. For Services, that means the Service must either be
		// in the same
		// namespace for a "producer" route, or the mesh implementation
		// must support
		// and allow "consumer" routes for the referenced Service.
		// ReferenceGrant is
		// not applicable for governing ParentRefs to Services - it is not
		// possible to
		// create a "producer" route for a Service in a different
		// namespace from the
		// Route.
		//
		// There are two kinds of parent resources with "Core" support:
		//
		// * Gateway (Gateway conformance profile)
		// * Service (Mesh conformance profile, ClusterIP Services only)
		//
		// This API may be extended in the future to support additional
		// kinds of parent
		// resources.
		//
		// ParentRefs must be _distinct_. This means either that:
		//
		// * They select different objects. If this is the case, then
		// parentRef
		// entries are distinct. In terms of fields, this means that the
		// multi-part key defined by `group`, `kind`, `namespace`, and
		// `name` must
		// be unique across all parentRef entries in the Route.
		// * They do not select different objects, but for each optional
		// field used,
		// each ParentRef that selects the same object must set the same
		// set of
		// optional fields to different values. If one ParentRef sets a
		// combination of optional fields, all must set the same
		// combination.
		//
		// Some examples:
		//
		// * If one ParentRef sets `sectionName`, all ParentRefs
		// referencing the
		// same object must also set `sectionName`.
		// * If one ParentRef sets `port`, all ParentRefs referencing the
		// same
		// object must also set `port`.
		// * If one ParentRef sets `sectionName` and `port`, all
		// ParentRefs
		// referencing the same object must also set `sectionName` and
		// `port`.
		//
		// It is possible to separately reference multiple distinct
		// objects that may
		// be collapsed by an implementation. For example, some
		// implementations may
		// choose to merge compatible Gateway Listeners together. If that
		// is the
		// case, the list of routes attached to those resources should
		// also be
		// merged.
		//
		// Note that for ParentRefs that cross namespace boundaries, there
		// are specific
		// rules. Cross-namespace references are only valid if they are
		// explicitly
		// allowed by something in the namespace they are referring to.
		// For example,
		// Gateway has the AllowedRoutes field, and ReferenceGrant
		// provides a
		// generic way to enable other kinds of cross-namespace reference.
		parentRefs?: list.MaxItems(32) & [...{
			// Group is the group of the referent.
			// When unspecified, "gateway.networking.k8s.io" is inferred.
			// To set the core API group (such as for a "Service" kind
			// referent),
			// Group must be explicitly set to "" (empty string).
			//
			// Support: Core
			group?: strings.MaxRunes(
				253) & =~"^$|^[a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*$"

			// Kind is kind of the referent.
			//
			// There are two kinds of parent resources with "Core" support:
			//
			// * Gateway (Gateway conformance profile)
			// * Service (Mesh conformance profile, ClusterIP Services only)
			//
			// Support for other resources is Implementation-Specific.
			kind?: strings.MaxRunes(
				63) & strings.MinRunes(
				1) & =~"^[a-zA-Z]([-a-zA-Z0-9]*[a-zA-Z0-9])?$"

			// Name is the name of the referent.
			//
			// Support: Core
			name!: strings.MaxRunes(
				253) & strings.MinRunes(
				1)

			// Namespace is the namespace of the referent. When unspecified,
			// this refers
			// to the local namespace of the Route.
			//
			// Note that there are specific rules for ParentRefs which cross
			// namespace
			// boundaries. Cross-namespace references are only valid if they
			// are explicitly
			// allowed by something in the namespace they are referring to.
			// For example:
			// Gateway has the AllowedRoutes field, and ReferenceGrant
			// provides a
			// generic way to enable any other kind of cross-namespace
			// reference.
			//
			// Support: Core
			namespace?: strings.MaxRunes(
					63) & strings.MinRunes(
					1) & =~"^[a-z0-9]([-a-z0-9]*[a-z0-9])?$"

			// Port is the network port this Route targets. It can be
			// interpreted
			// differently based on the type of parent resource.
			//
			// When the parent resource is a Gateway, this targets all
			// listeners
			// listening on the specified port that also support this kind of
			// Route(and
			// select this Route). It's not recommended to set `Port` unless
			// the
			// networking behaviors specified in a Route must apply to a
			// specific port
			// as opposed to a listener(s) whose port(s) may be changed. When
			// both Port
			// and SectionName are specified, the name and port of the
			// selected listener
			// must match both specified values.
			//
			// Implementations MAY choose to support other parent resources.
			// Implementations supporting other types of parent resources MUST
			// clearly
			// document how/if Port is interpreted.
			//
			// For the purpose of status, an attachment is considered
			// successful as
			// long as the parent resource accepts it partially. For example,
			// Gateway
			// listeners can restrict which Routes can attach to them by Route
			// kind,
			// namespace, or hostname. If 1 of 2 Gateway listeners accept
			// attachment
			// from the referencing Route, the Route MUST be considered
			// successfully
			// attached. If no Gateway listeners accept attachment from this
			// Route,
			// the Route MUST be considered detached from the Gateway.
			//
			// Support: Extended
			port?: int32 & int & <=65535 & >=1

			// SectionName is the name of a section within the target
			// resource. In the
			// following resources, SectionName is interpreted as the
			// following:
			//
			// * Gateway: Listener name. When both Port (experimental) and
			// SectionName
			// are specified, the name and port of the selected listener must
			// match
			// both specified values.
			// * Service: Port name. When both Port (experimental) and
			// SectionName
			// are specified, the name and port of the selected listener must
			// match
			// both specified values.
			//
			// Implementations MAY choose to support attaching Routes to other
			// resources.
			// If that is the case, they MUST clearly document how SectionName
			// is
			// interpreted.
			//
			// When unspecified (empty string), this will reference the entire
			// resource.
			// For the purpose of status, an attachment is considered
			// successful if at
			// least one section in the parent resource accepts it. For
			// example, Gateway
			// listeners can restrict which Routes can attach to them by Route
			// kind,
			// namespace, or hostname. If 1 of 2 Gateway listeners accept
			// attachment from
			// the referencing Route, the Route MUST be considered
			// successfully
			// attached. If no Gateway listeners accept attachment from this
			// Route, the
			// Route MUST be considered detached from the Gateway.
			//
			// Support: Core
			sectionName?: strings.MaxRunes(
					253) & strings.MinRunes(
					1) & =~"^[a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*$"
		}]

		// Rules are a list of actions.
		rules!: list.MaxItems(1) & [...{
			// BackendRefs defines the backend(s) where matching requests
			// should be
			// sent. If unspecified or invalid (refers to a nonexistent
			// resource or
			// a Service with no endpoints), the rule performs no forwarding;
			// if no
			// filters are specified that would result in a response being
			// sent, the
			// underlying implementation must actively reject request attempts
			// to this
			// backend, by rejecting the connection. Request rejections must
			// respect
			// weight; if an invalid backend is requested to have 80% of
			// requests, then
			// 80% of requests must be rejected instead.
			//
			// Support: Core for Kubernetes Service
			//
			// Support: Extended for Kubernetes ServiceImport
			//
			// Support: Implementation-specific for any other resource
			//
			// Support for weight: Extended
			backendRefs!: list.MaxItems(16) & [...{
				// Group is the group of the referent. For example,
				// "gateway.networking.k8s.io".
				// When unspecified or empty string, core API group is inferred.
				group?: strings.MaxRunes(
					253) & =~"^$|^[a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*$"

				// Kind is the Kubernetes resource kind of the referent. For
				// example
				// "Service".
				//
				// Defaults to "Service" when not specified.
				//
				// ExternalName services can refer to CNAME DNS records that may
				// live
				// outside of the cluster and as such are difficult to reason
				// about in
				// terms of conformance. They also may not be safe to forward to
				// (see
				// CVE-2021-25740 for more information). Implementations SHOULD
				// NOT
				// support ExternalName Services.
				//
				// Support: Core (Services with a type other than ExternalName)
				//
				// Support: Implementation-specific (Services with type
				// ExternalName)
				kind?: strings.MaxRunes(
					63) & strings.MinRunes(
					1) & =~"^[a-zA-Z]([-a-zA-Z0-9]*[a-zA-Z0-9])?$"

				// Name is the name of the referent.
				name!: strings.MaxRunes(
					253) & strings.MinRunes(
					1)

				// Namespace is the namespace of the backend. When unspecified,
				// the local
				// namespace is inferred.
				//
				// Note that when a namespace different than the local namespace
				// is specified,
				// a ReferenceGrant object is required in the referent namespace
				// to allow that
				// namespace's owner to accept the reference. See the
				// ReferenceGrant
				// documentation for details.
				//
				// Support: Core
				namespace?: strings.MaxRunes(
						63) & strings.MinRunes(
						1) & =~"^[a-z0-9]([-a-z0-9]*[a-z0-9])?$"

				// Port specifies the destination port number to use for this
				// resource.
				// Port is required when the referent is a Kubernetes Service. In
				// this
				// case, the port number is the service port number, not the
				// target port.
				// For other resources, destination port might be derived from the
				// referent
				// resource or this field.
				port?: int32 & int & <=65535 & >=1

				// Weight specifies the proportion of requests forwarded to the
				// referenced
				// backend. This is computed as weight/(sum of all weights in this
				// BackendRefs list). For non-zero values, there may be some
				// epsilon from
				// the exact proportion defined here depending on the precision an
				// implementation supports. Weight is not a percentage and the sum
				// of
				// weights does not need to equal 100.
				//
				// If only one backend is specified and it has a weight greater
				// than 0, 100%
				// of the traffic is forwarded to that backend. If weight is set
				// to 0, no
				// traffic should be forwarded for this entry. If unspecified,
				// weight
				// defaults to 1.
				//
				// Support for this field varies based on the context where used.
				weight?: int32 & int & <=1000000 & >=0
			}] & [_, ...]

			// Name is the name of the route rule. This name MUST be unique
			// within a Route if it is set.
			name?: strings.MaxRunes(
				253) & strings.MinRunes(
				1) & =~"^[a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*$"
		}] & [_, ...]
	}

	// Status defines the current state of TLSRoute.
	status?: {
		// Parents is a list of parent resources (usually Gateways) that
		// are
		// associated with the route, and the status of the route with
		// respect to
		// each parent. When this route attaches to a parent, the
		// controller that
		// manages the parent must add an entry to this list when the
		// controller
		// first sees the route and should update the entry as appropriate
		// when the
		// route or gateway is modified.
		//
		// Note that parent references that cannot be resolved by an
		// implementation
		// of this API will not be added to this list. Implementations of
		// this API
		// can only populate Route status for the Gateways/parent
		// resources they are
		// responsible for.
		//
		// A maximum of 32 Gateways will be represented in this list. An
		// empty list
		// means the route has not been attached to any Gateway.
		parents!: list.MaxItems(32) & [...{
			// Conditions describes the status of the route with respect to
			// the Gateway.
			// Note that the route's availability is also subject to the
			// Gateway's own
			// status conditions and listener status.
			//
			// If the Route's ParentRef specifies an existing Gateway that
			// supports
			// Routes of this kind AND that Gateway's controller has
			// sufficient access,
			// then that Gateway's controller MUST set the "Accepted"
			// condition on the
			// Route, to indicate whether the route has been accepted or
			// rejected by the
			// Gateway, and why.
			//
			// A Route MUST be considered "Accepted" if at least one of the
			// Route's
			// rules is implemented by the Gateway.
			//
			// There are a number of cases where the "Accepted" condition may
			// not be set
			// due to lack of controller visibility, that includes when:
			//
			// * The Route refers to a nonexistent parent.
			// * The Route is of a type that the controller does not support.
			// * The Route is in a namespace to which the controller does not
			// have access.
			conditions!: list.MaxItems(8) & [...{
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
			}] & [_, ...]

			// ControllerName is a domain/path string that indicates the name
			// of the
			// controller that wrote this status. This corresponds with the
			// controllerName field on GatewayClass.
			//
			// Example: "example.net/gateway-controller".
			//
			// The format of this field is DOMAIN "/" PATH, where DOMAIN and
			// PATH are
			// valid Kubernetes names
			// (https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names).
			//
			// Controllers MUST populate this field when writing status.
			// Controllers should ensure that
			// entries to status populated with their ControllerName are
			// cleaned up when they are no
			// longer necessary.
			controllerName!: strings.MaxRunes(
						253) & strings.MinRunes(
						1) & =~"^[a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*\\/[A-Za-z0-9\\/\\-._~%!$&'()*+,;=:]+$"

			// ParentRef corresponds with a ParentRef in the spec that this
			// RouteParentStatus struct describes the status of.
			parentRef!: {
				// Group is the group of the referent.
				// When unspecified, "gateway.networking.k8s.io" is inferred.
				// To set the core API group (such as for a "Service" kind
				// referent),
				// Group must be explicitly set to "" (empty string).
				//
				// Support: Core
				group?: strings.MaxRunes(
					253) & =~"^$|^[a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*$"

				// Kind is kind of the referent.
				//
				// There are two kinds of parent resources with "Core" support:
				//
				// * Gateway (Gateway conformance profile)
				// * Service (Mesh conformance profile, ClusterIP Services only)
				//
				// Support for other resources is Implementation-Specific.
				kind?: strings.MaxRunes(
					63) & strings.MinRunes(
					1) & =~"^[a-zA-Z]([-a-zA-Z0-9]*[a-zA-Z0-9])?$"

				// Name is the name of the referent.
				//
				// Support: Core
				name!: strings.MaxRunes(
					253) & strings.MinRunes(
					1)

				// Namespace is the namespace of the referent. When unspecified,
				// this refers
				// to the local namespace of the Route.
				//
				// Note that there are specific rules for ParentRefs which cross
				// namespace
				// boundaries. Cross-namespace references are only valid if they
				// are explicitly
				// allowed by something in the namespace they are referring to.
				// For example:
				// Gateway has the AllowedRoutes field, and ReferenceGrant
				// provides a
				// generic way to enable any other kind of cross-namespace
				// reference.
				//
				// Support: Core
				namespace?: strings.MaxRunes(
						63) & strings.MinRunes(
						1) & =~"^[a-z0-9]([-a-z0-9]*[a-z0-9])?$"

				// Port is the network port this Route targets. It can be
				// interpreted
				// differently based on the type of parent resource.
				//
				// When the parent resource is a Gateway, this targets all
				// listeners
				// listening on the specified port that also support this kind of
				// Route(and
				// select this Route). It's not recommended to set `Port` unless
				// the
				// networking behaviors specified in a Route must apply to a
				// specific port
				// as opposed to a listener(s) whose port(s) may be changed. When
				// both Port
				// and SectionName are specified, the name and port of the
				// selected listener
				// must match both specified values.
				//
				// Implementations MAY choose to support other parent resources.
				// Implementations supporting other types of parent resources MUST
				// clearly
				// document how/if Port is interpreted.
				//
				// For the purpose of status, an attachment is considered
				// successful as
				// long as the parent resource accepts it partially. For example,
				// Gateway
				// listeners can restrict which Routes can attach to them by Route
				// kind,
				// namespace, or hostname. If 1 of 2 Gateway listeners accept
				// attachment
				// from the referencing Route, the Route MUST be considered
				// successfully
				// attached. If no Gateway listeners accept attachment from this
				// Route,
				// the Route MUST be considered detached from the Gateway.
				//
				// Support: Extended
				port?: int32 & int & <=65535 & >=1

				// SectionName is the name of a section within the target
				// resource. In the
				// following resources, SectionName is interpreted as the
				// following:
				//
				// * Gateway: Listener name. When both Port (experimental) and
				// SectionName
				// are specified, the name and port of the selected listener must
				// match
				// both specified values.
				// * Service: Port name. When both Port (experimental) and
				// SectionName
				// are specified, the name and port of the selected listener must
				// match
				// both specified values.
				//
				// Implementations MAY choose to support attaching Routes to other
				// resources.
				// If that is the case, they MUST clearly document how SectionName
				// is
				// interpreted.
				//
				// When unspecified (empty string), this will reference the entire
				// resource.
				// For the purpose of status, an attachment is considered
				// successful if at
				// least one section in the parent resource accepts it. For
				// example, Gateway
				// listeners can restrict which Routes can attach to them by Route
				// kind,
				// namespace, or hostname. If 1 of 2 Gateway listeners accept
				// attachment from
				// the referencing Route, the Route MUST be considered
				// successfully
				// attached. If no Gateway listeners accept attachment from this
				// Route, the
				// Route MUST be considered detached from the Gateway.
				//
				// Support: Core
				sectionName?: strings.MaxRunes(
						253) & strings.MinRunes(
						1) & =~"^[a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*$"
			}
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
	kind:       "TLSRoute"
	metadata!: {
		name!:      string
		namespace!: string
		labels?: [string]: string
		annotations?: [string]: string
		...
	}
}
