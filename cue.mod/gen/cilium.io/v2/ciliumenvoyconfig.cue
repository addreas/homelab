package v2

import "strings"

#CiliumEnvoyConfig: {
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
	spec?: {
		// BackendServices specifies Kubernetes services whose backends
		// are automatically synced to Envoy using EDS. Traffic for these
		// services is not forwarded to an Envoy listener. This allows an
		// Envoy listener load balance traffic to these backends while
		// normal Cilium service load balancing takes care of balancing
		// traffic for these services at the same time.
		backendServices?: [...{
			// Name is the name of a destination Kubernetes service that
			// identifies traffic
			// to be redirected.
			name!: string

			// Namespace is the Kubernetes service namespace.
			// In CiliumEnvoyConfig namespace defaults to the namespace of the
			// CEC,
			// In CiliumClusterwideEnvoyConfig namespace defaults to
			// "default".
			namespace?: string

			// Ports is a set of port numbers, which can be used for filtering
			// in case of underlying
			// is exposing multiple port numbers.
			number?: [...string]
		}]

		// NodeSelector is a label selector that determines to which nodes
		// this configuration applies.
		// If nil, then this config applies to all nodes.
		nodeSelector?: {
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

		// Envoy xDS resources, a list of the following Envoy resource
		// types:
		// type.googleapis.com/envoy.config.listener.v3.Listener,
		// type.googleapis.com/envoy.config.route.v3.RouteConfiguration,
		// type.googleapis.com/envoy.config.cluster.v3.Cluster,
		// type.googleapis.com/envoy.config.endpoint.v3.ClusterLoadAssignment,
		// and
		// type.googleapis.com/envoy.extensions.transport_sockets.tls.v3.Secret.
		resources!: [...{
			...
		}]

		// Services specifies Kubernetes services for which traffic is
		// forwarded to an Envoy listener for L7 load balancing. Backends
		// of these services are automatically synced to Envoy usign EDS.
		services?: [...{
			// Listener specifies the name of the Envoy listener the
			// service traffic is redirected to. The listener must be
			// specified in the Envoy 'resources' of the same
			// CiliumEnvoyConfig.
			//
			// If omitted, the first listener specified in 'resources' is
			// used.
			listener?: string

			// Name is the name of a destination Kubernetes service that
			// identifies traffic
			// to be redirected.
			name!: string

			// Namespace is the Kubernetes service namespace.
			// In CiliumEnvoyConfig namespace this is overridden to the
			// namespace of the CEC,
			// In CiliumClusterwideEnvoyConfig namespace defaults to
			// "default".
			namespace?: string

			// Ports is a set of service's frontend ports that should be
			// redirected to the Envoy
			// listener. By default all frontend ports of the service are
			// redirected.
			ports?: [...int]
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
	kind:       "CiliumEnvoyConfig"
	metadata!: {
		name!:      string
		namespace!: string
		labels?: [string]: string
		annotations?: [string]: string
		...
	}
}
