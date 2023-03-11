package kube

k: [string]: [string]: metadata: namespace: *"default" | string

k: CueExport: "homelab-hass": spec: {
	interval:  "30m"
	sourceRef: _homelab
	paths: ["./resources/hass"]
	prune:   true
	suspend: false
}
