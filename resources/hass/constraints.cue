package kube

k: [string]: [string]: metadata: namespace: *"default" | string

// for some reason doesn't find any resources:
// k: CueBuild: "homelab-hass": spec: {
// 	interval:  "30m"
// 	sourceRef: _homelab
// 	packages: ["./resources/hass"]
// 	prune:   true
// 	suspend: false
// }
