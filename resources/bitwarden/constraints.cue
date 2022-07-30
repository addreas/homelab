package kube

k: [string]: [string]: metadata: {
	namespace: *"default" | string
	labels: app: "bitwarden"
}

k: CueBuild: "homelab-bitwarden": spec: {
	interval:  "30m"
	sourceRef: _homelab
	packages: ["./resources/bitwarden"]
	prune:   false
	suspend: false
}
