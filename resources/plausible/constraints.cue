package kube

k: [string]: [string]: metadata: namespace: *"plausible" | string

k: CueExport: "homelab-plausible": spec: {
	interval:  "30m"
	sourceRef: _homelab
	paths: ["./resources/plausible"]
	prune:   true
	suspend: false
}
