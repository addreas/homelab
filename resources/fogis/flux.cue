package kube 

k: CueExport: "homelab-fogis": spec: {
	interval:  "30m"
	sourceRef: _homelab
	paths: ["./resources/fogis/namespace", "./resources/fogis/logger", "./resources/fogis/calendar", "./resources/fogis"]
	prune:   true
	suspend: false
}
