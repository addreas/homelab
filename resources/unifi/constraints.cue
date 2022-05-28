package kube

k: [string]: [string]: metadata: namespace: *"default" | string

k: CueBuild: "homelab-unifi": spec: {
	interval:  "30m"
	sourceRef: _homelab
	packages: ["./resources/unifi"]
	prune:   false
	suspend: false
}
