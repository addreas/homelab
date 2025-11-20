package v2

#CiliumEndpoint: {
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

	// EndpointStatus is the status of a Cilium endpoint.
	status?: {
		// Controllers is the list of failing controllers for this
		// endpoint.
		controllers?: [...{
			// Configuration is the controller configuration
			configuration?: {
				// Retry on error
				"error-retry"?: bool

				// Base error retry back-off time
				// Format: duration
				"error-retry-base"?: int64 & int

				// Regular synchronization interval
				// Format: duration
				interval?: int64 & int
			}

			// Name is the name of the controller
			name?: string

			// Status is the status of the controller
			status?: {
				"consecutive-failure-count"?: int64 & int
				"failure-count"?:             int64 & int
				"last-failure-msg"?:          string
				"last-failure-timestamp"?:    string
				"last-success-timestamp"?:    string
				"success-count"?:             int64 & int
			}

			// UUID is the UUID of the controller
			uuid?: string
		}]

		// Encryption is the encryption configuration of the node
		encryption?: {
			// Key is the index to the key to use for encryption or 0 if
			// encryption is
			// disabled.
			key?: int
		}

		// ExternalIdentifiers is a set of identifiers to identify the
		// endpoint
		// apart from the pod name. This includes container runtime IDs.
		"external-identifiers"?: {
			// ID assigned to this attachment by container runtime
			"cni-attachment-id"?: string

			// ID assigned by container runtime (deprecated, may not be
			// unique)
			"container-id"?: string

			// Name assigned to container (deprecated, may not be unique)
			"container-name"?: string

			// Docker endpoint ID
			"docker-endpoint-id"?: string

			// Docker network ID
			"docker-network-id"?: string

			// K8s namespace for this endpoint (deprecated, may not be unique)
			"k8s-namespace"?: string

			// K8s pod name for this endpoint (deprecated, may not be unique)
			"k8s-pod-name"?: string

			// K8s pod for this endpoint (deprecated, may not be unique)
			"pod-name"?: string
		}

		// Health is the overall endpoint & subcomponent health.
		health?: {
			// bpf
			bpf?: string

			// Is this endpoint reachable
			connected?: bool

			// overall health
			overallHealth?: string

			// policy
			policy?: string
		}

		// ID is the cilium-agent-local ID of the endpoint.
		id?: int64 & int

		// Identity is the security identity associated with the endpoint
		identity?: {
			// ID is the numeric identity of the endpoint
			id?: int64 & int

			// Labels is the list of labels associated with the identity
			labels?: [...string]
		}

		// Log is the list of the last few warning and error log entries
		log?: [...{
			// Code indicate type of status change
			// Enum: ["ok","failed"]
			code?: string

			// Status message
			message?: string

			// state
			state?: string

			// Timestamp when status change occurred
			timestamp?: string
		}]

		// NamedPorts List of named Layer 4 port and protocol pairs which
		// will be used in Network
		// Policy specs.
		//
		// swagger:model NamedPorts
		"named-ports"?: [...{
			// Optional layer 4 port name
			name?: string

			// Layer 4 port number
			port?: int

			// Layer 4 protocol
			// Enum: ["TCP","UDP","SCTP","ICMP","ICMPV6","ANY"]
			protocol?: string
		}]

		// Networking is the networking properties of the endpoint.
		networking?: {
			// IP4/6 addresses assigned to this Endpoint
			addressing!: [...{
				ipv4?: string
				ipv6?: string
			}]

			// NodeIP is the IP of the node the endpoint is running on. The IP
			// must
			// be reachable between nodes.
			node?: string
		}

		// EndpointPolicy represents the endpoint's policy by listing all
		// allowed
		// ingress and egress identities in combination with L4 port and
		// protocol.
		policy?: {
			// EndpointPolicyDirection is the list of allowed identities per
			// direction.
			egress?: {
				// Deprecated
				adding?: [...{
					"dest-port"?: int
					identity?:    int64 & int
					"identity-labels"?: [string]: string
					protocol?: int
				}]

				// AllowedIdentityList is a list of IdentityTuples that species
				// peers that are
				// allowed.
				allowed?: [...{
					"dest-port"?: int
					identity?:    int64 & int
					"identity-labels"?: [string]: string
					protocol?: int
				}]

				// DenyIdentityList is a list of IdentityTuples that species peers
				// that are
				// denied.
				denied?: [...{
					"dest-port"?: int
					identity?:    int64 & int
					"identity-labels"?: [string]: string
					protocol?: int
				}]
				enforcing!: bool

				// Deprecated
				removing?: [...{
					"dest-port"?: int
					identity?:    int64 & int
					"identity-labels"?: [string]: string
					protocol?: int
				}]

				// EndpointPolicyState defines the state of the Policy mode:
				// "enforcing", "non-enforcing", "disabled"
				state?: string
			}

			// EndpointPolicyDirection is the list of allowed identities per
			// direction.
			ingress?: {
				// Deprecated
				adding?: [...{
					"dest-port"?: int
					identity?:    int64 & int
					"identity-labels"?: [string]: string
					protocol?: int
				}]

				// AllowedIdentityList is a list of IdentityTuples that species
				// peers that are
				// allowed.
				allowed?: [...{
					"dest-port"?: int
					identity?:    int64 & int
					"identity-labels"?: [string]: string
					protocol?: int
				}]

				// DenyIdentityList is a list of IdentityTuples that species peers
				// that are
				// denied.
				denied?: [...{
					"dest-port"?: int
					identity?:    int64 & int
					"identity-labels"?: [string]: string
					protocol?: int
				}]
				enforcing!: bool

				// Deprecated
				removing?: [...{
					"dest-port"?: int
					identity?:    int64 & int
					"identity-labels"?: [string]: string
					protocol?: int
				}]

				// EndpointPolicyState defines the state of the Policy mode:
				// "enforcing", "non-enforcing", "disabled"
				state?: string
			}
		}

		// State is the state of the endpoint.
		state?: "creating" | "waiting-for-identity" | "not-ready" | "waiting-to-regenerate" | "regenerating" | "restoring" | "ready" | "disconnecting" | "disconnected" | "invalid"
	}

	_embeddedResource: {
		apiVersion!: string
		kind!:       string
		metadata?: {
			...
		}
	}
	apiVersion: "cilium.io/v2"
	kind:       "CiliumEndpoint"
	metadata!: {
		name!:      string
		namespace!: string
		labels?: [string]: string
		annotations?: [string]: string
		...
	}
}
