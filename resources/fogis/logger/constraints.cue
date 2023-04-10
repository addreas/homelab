package kube

k: CueExport: "homelab-fogis-logger": spec: {
	interval:  "30m"
	sourceRef: _homelab
	paths: ["./resources/fogis/logger"]
	prune:   true
	suspend: false
}
