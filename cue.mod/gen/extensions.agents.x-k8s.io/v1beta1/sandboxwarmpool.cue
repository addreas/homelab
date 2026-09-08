package v1beta1

#SandboxWarmPool: {
	_embeddedResource
	apiVersion?: string
	kind?:       string
	metadata?: {}
	spec!: {
		replicas?: int32 & int & >=0
		sandboxTemplateRef!: name!: string
		updateStrategy?: type?:     "Recreate" | "OnReplenish"
	}
	status?: {
		observedGeneration?: int64 & int & >=0
		readyReplicas?:      int32 & int
		replicas?:           int32 & int
		selector?:           string
	}

	_embeddedResource: {
		apiVersion!: string
		kind!:       string
		metadata?: {
			...
		}
	}
	apiVersion: "extensions.agents.x-k8s.io/v1beta1"
	kind:       "SandboxWarmPool"
	metadata!: {
		name!:      string
		namespace!: string
		labels?: [string]: string
		annotations?: [string]: string
		...
	}
}
