package kube

k: [string]: [string]: metadata: namespace: *"fogis" | string

k: CueExport: "homelab-fogis": spec: {
	interval:  "30m"
	sourceRef: _homelab
	paths: ["./resources/fogis"]
	prune:   true
	suspend: false
}
