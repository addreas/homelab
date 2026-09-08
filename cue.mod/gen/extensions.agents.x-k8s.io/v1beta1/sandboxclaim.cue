package v1beta1

import (
	"time"
	"strings"
)

#SandboxClaim: {
	_embeddedResource
	apiVersion?: string
	kind?:       string
	metadata?: {}
	spec!: {
		additionalPodMetadata?: {
			annotations?: [string]: string
			labels?: [string]:      string
		}
		env?: [...{
			containerName?: string
			name!:          string
			value!:         string
		}]
		lifecycle?: {
			shutdownPolicy?:          "Delete" | "DeleteForeground" | "Retain"
			shutdownTime?:            time.Time
			ttlSecondsAfterFinished?: int32 & int & >=0
		}
		volumeClaimTemplates?: [...{
			metadata?: {
				annotations?: [string]: string
				labels?: [string]:      string
				name?: string
			}
			spec!: {
				accessModes?: [...string]
				dataSource?: {
					apiGroup?: string
					kind!:     string
					name!:     string
				}
				dataSourceRef?: {
					apiGroup?:  string
					kind!:      string
					name!:      string
					namespace?: string
				}
				resources?: {
					limits?: [string]: matchN(>=1, [int, string]) & (int | =~"^(\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))(([KMGTPE]i)|[numkMGTPE]|([eE](\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))))?$")
					requests?: [string]: matchN(>=1, [int, string]) & (int | =~"^(\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))(([KMGTPE]i)|[numkMGTPE]|([eE](\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))))?$")
				}
				selector?: {
					matchExpressions?: [...{
						key!:      string
						operator!: string
						values?: [...string]
					}]
					matchLabels?: [string]: string
				}
				storageClassName?:          string
				volumeAttributesClassName?: string
				volumeMode?:                string
				volumeName?:                string
			}
		}]
		warmPoolRef!: name!: string
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
		sandbox?: {
			name?: string
			podIPs?: [...string]
			serviceFQDN?: string
		}
	}

	_embeddedResource: {
		apiVersion!: string
		kind!:       string
		metadata?: {
			...
		}
	}
	apiVersion: "extensions.agents.x-k8s.io/v1beta1"
	kind:       "SandboxClaim"
	metadata!: {
		name!:      string
		namespace!: string
		labels?: [string]: string
		annotations?: [string]: string
		...
	}
}
