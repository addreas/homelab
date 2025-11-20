package v2alpha1

#CiliumPodIPPool: {
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
	spec!: {
		// IPv4 specifies the IPv4 CIDRs and mask sizes of the pool
		ipv4?: {
			// CIDRs is a list of IPv4 CIDRs that are part of the pool.
			cidrs!: [...string] & [_, ...]

			// MaskSize is the mask size of the pool.
			maskSize!: int & <=32 & >=1
		}

		// IPv6 specifies the IPv6 CIDRs and mask sizes of the pool
		ipv6?: {
			// CIDRs is a list of IPv6 CIDRs that are part of the pool.
			cidrs!: [...string] & [_, ...]

			// MaskSize is the mask size of the pool.
			maskSize!: int & <=128 & >=1
		}
	}

	_embeddedResource: {
		apiVersion!: string
		kind!:       string
		metadata?: {
			...
		}
	}
	apiVersion: "cilium.io/v2alpha1"
	kind:       "CiliumPodIPPool"
	metadata!: {
		name!:      string
		namespace?: string
		labels?: [string]: string
		annotations?: [string]: string
		...
	}
}
