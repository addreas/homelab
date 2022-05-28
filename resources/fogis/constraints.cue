package kube

k: [string]: [string]: metadata: namespace: *"fogis" | string

k: CueBuild: "homelab-fogis": spec: {
	interval:  "30m"
	sourceRef: _homelab
	packages: ["./resources/fogis"]
	prune:   true
	suspend: false
}
