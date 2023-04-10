package kube

k: CueExport: "homelab-fogis-calendar": spec: {
	interval:  "30m"
	sourceRef: _homelab
	paths: ["./resources/fogis/calendar"]
	prune:   true
	suspend: false
}
