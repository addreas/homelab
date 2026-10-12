package kube

_namespace: "trippler"

k: CueExport: "homelab-trippler": spec: {
	interval:  "30m"
	sourceRef: _homelab
	paths: ["./resources/trippler"]
	prune:   true
	suspend: false
}
