package kube

Labels: app: "fogis"

k: [string]: [string]: metadata: {
	namespace: *"fogis" | string
	labels:    Labels
}
