package v1beta1

import (
	"struct"
	"time"
	"strings"
)

#GrafanaDashboard: {
	_embeddedResource
	apiVersion?: string
	kind?:       string
	metadata?: {}
	spec?: {
		allowCrossNamespaceReferences?: bool
		datasources?: [...{
			datasourceRef!: {
				apiVersion?:      string
				fieldPath?:       string
				kind?:            string
				name?:            string
				namespace?:       string
				resourceVersion?: string
				uid?:             string
			}
			inputName!: string
		}]
		folder?: string
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
		source!: struct.MinFields(
			1) & struct.MaxFields(
			1) & {
				configMap?: {
					key!:      string
					name?:     string
					optional?: bool
				}
				inline?: struct.MinFields(
					1) & struct.MaxFields(
					1) & {
						gzipJson?: string
						json?:     string
						jsonnet?:  string
					}
				remote?: struct.MinFields(
					2) & struct.MaxFields(
					2) & {
						contentCacheDuration!: string
						grafanaCom?: {
							id!:       int
							revision?: int
						}
						url?: string
					}
			}
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
		content?: {
			cache?:     string
			timestamp?: time.Time
			url!:       string
		}
		contentError?: {
			attempts!:  int
			message!:   string
			timestamp!: time.Time
		}
		instances?: [string]: {
			UID?:     string
			Version?: int64 & int
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
	kind:       "GrafanaDashboard"
	metadata!: {
		name!:      string
		namespace!: string
		labels?: [string]: string
		annotations?: [string]: string
		...
	}
}
