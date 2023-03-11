package kube

k: [string]: [string]: metadata: {
	namespace: *"default" | string
	labels: app: "bitwarden"
}

k: CueExport: "homelab-bitwarden": spec: {
	interval:  "30m"
	sourceRef: _homelab
	paths: ["./resources/bitwarden"]
	prune:   false
	suspend: false
}
