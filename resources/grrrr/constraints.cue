package kube

k: [string]: [string]: metadata: {
	namespace: *"grrrr" | string
}

k: CueBuild: "homelab-grrrr": spec: {
	interval:  "30m"
	sourceRef: _homelab
	packages: ["./resources/grrrr"]
	prune:   true
	suspend: false
}
