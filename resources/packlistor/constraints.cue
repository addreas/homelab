package kube

k: [string]: [string]: metadata: namespace: *"packlistor" | string

k: CueExport: "homelab-packlistor": spec: {
	interval:  "30m"
	sourceRef: _homelab
	paths: ["./resources/packlistor"]
	prune:   true
	suspend: false
}
