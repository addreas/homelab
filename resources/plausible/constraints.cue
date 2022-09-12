package kube

k: [string]: [string]: metadata: namespace: *"plausible" | string

k: CueBuild: "homelab-plausible": spec: {
	interval:  "30m"
	sourceRef: _homelab
	packages: ["./resources/plausible"]
	prune:   true
	suspend: false
}
