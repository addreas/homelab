package kube

k: [string]: [string]: metadata: namespace: *"default" | string

k: CueExport: "homelab-unifi": spec: {
	interval:  "30m"
	sourceRef: _homelab
	paths: ["./resources/unifi"]
	prune:   false
	suspend: false
}
