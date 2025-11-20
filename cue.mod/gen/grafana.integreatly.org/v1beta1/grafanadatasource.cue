package v1beta1

import (
	"time"
	"strings"
)

#GrafanaDatasource: {
	_embeddedResource
	apiVersion?: string
	kind?:       string
	metadata?: {}
	spec?: {
		allowCrossNamespaceImport?: bool
		datasource?: {
			access!:        string
			basicAuth!:     bool
			basicAuthUser?: string
			database?:      string
			id?:            int64 & int
			isDefault!:     bool
			jsonData?: {
				...
			}
			name!:  string
			orgId?: int64 & int
			secureJsonData?: {
				...
			}
			type!: string
			uid?:  string
			url!:  string
			user?: string
		}
		instanceSelector?: {
			matchExpressions?: [...{
				key!:      string
				operator!: string
				values?: [...string]
			}]
			matchLabels?: [string]: string
		}
		interval!: string
		plugins?: [...{
			name!:    string
			version!: string
		}]
		valuesFrom?: [...{
			targetPath!: string
			valueFrom!: {
				configMapKeyRef?: {
					key!:      string
					name?:     string
					optional?: bool
				}
				secretKeyRef?: {
					key!:      string
					name?:     string
					optional?: bool
				}
			}
		}]
	}
	status?: {
		conditions?: [...{
			lastTransitionTime!: time.Time
			message!:            strings.MaxRunes(
						32768)
			observedGeneration?: int64 & int & >=0
			reason!:             strings.MaxRunes(
						1024) & strings.MinRunes(
						1) & =~"^[A-Za-z]([A-Za-z0-9_,:]*[A-Za-z0-9_])?$"
			status!:             "True" | "False" | "Unknown"
			type!:               strings.MaxRunes(
						316) & =~"^([a-z0-9]([-a-z0-9]*[a-z0-9])?(\\.[a-z0-9]([-a-z0-9]*[a-z0-9])?)*/)?(([A-Za-z0-9][-A-Za-z0-9_.]*)?[A-Za-z0-9])$"
		}]
		instances?: [string]: {
			ID?:  int64 & int
			UID?: string
		}
	}

	_embeddedResource: {
		apiVersion!: string
		kind!:       string
		metadata?: {
			...
		}
	}
	apiVersion: "grafana.integreatly.org/v1beta1"
	kind:       "GrafanaDatasource"
	metadata!: {
		name!:      string
		namespace!: string
		labels?: [string]: string
		annotations?: [string]: string
		...
	}
}
