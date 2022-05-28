package kube

k: [string]: [string]: metadata: namespace: *"default" | string

k: CueBuild: "homelab-default": spec: {
	interval:  "30m"
	sourceRef: _homelab
	packages: ["./resources/default"]
	prune:   true
	suspend: false
}
