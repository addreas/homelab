package kube

k: Namespace: "wsguard": {}

k: [string]: [string]: metadata: namespace: "wsguard"

k: ["Deployment" | "Job"]: [string]: spec: template: spec: {
	securityContext: fsGroup: 0
	containers: [...{
		securityContext: {
			runAsUser:                0
			runAsGroup:               0
		}
	}]
}