package kube

k: [string]: [string]: metadata: {
	namespace: *"default" | string
	labels: "app": "hass"
}
