package kube

k: [string]: [string]: metadata: namespace: *"default" | string

k: CueExport: "homelab-default": spec: {
	interval:  "30m"
	sourceRef: _homelab
	paths: ["./resources/default"]
	prune:   true
	suspend: false
}
