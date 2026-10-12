package kube

_namespace: "hass"

k: CueExport: "homelab-hass": spec: {
	interval:  "30m"
	sourceRef: _homelab
	paths: ["./resources/hass"]
	prune:   true
	suspend: false
}
