package kube

_namespace: "grrrr"

k: CueExport: "homelab-grrrr": spec: {
	interval:  "30m"
	sourceRef: _homelab
	paths: ["./resources/grrrr"]
	prune:   true
	suspend: false
}
