package kube

_namespace: "grrrr"

k: StatefulSet: [string]: spec: template: metadata: labels: "vpn-egress": "client"

k: CueExport: "homelab-grrrr": spec: {
	interval:  "30m"
	sourceRef: _homelab
	paths: ["./resources/grrrr"]
	prune:   true
	suspend: false
}
