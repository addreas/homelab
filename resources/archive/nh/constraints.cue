package kube

k: [string]: [string]: metadata: namespace: "nh"

k: Deployment: [string]: spec: template: spec: containers: [...{
	resources: {
		requests: {
			memory: "256Mi"
			cpu:    "50m"
		}
		limits: {
			memory: "512Mi"
			cpu:    "500m"
		}
	}
}]
