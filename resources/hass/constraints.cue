package kube

k: [string]: [string]: metadata: namespace: *"default" | string

k: CueBuild: "homelab-hass": spec: {
	interval:  "30m"
	sourceRef: _homelab
	packages: ["./resources/hass"]
	prune:   true
	suspend: false
}
