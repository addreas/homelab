package v1beta1

#GrafanaFolder: {
	_embeddedResource
	apiVersion?: string
	kind?:       string
	metadata?: {}
	spec?: {
		allowCrossNamespaceImport?: bool
		instanceSelector!: {
			matchExpressions?: [...{
				key!:      string
				operator!: string
				values?: [...string]
			}]
			matchLabels?: [string]: string
		}
		json?: string
	}
	status?: {
		NoMatchingInstances?: bool
		hash?:                string
	}

	_embeddedResource: {
		apiVersion!: string
		kind!:       string
		metadata?: {
			...
		}
	}
	apiVersion: "grafana.integreatly.org/v1beta1"
	kind:       "GrafanaFolder"
	metadata!: {
		name!:      string
		namespace!: string
		labels?: [string]: string
		annotations?: [string]: string
		...
	}
}
