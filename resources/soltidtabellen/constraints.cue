package kube

_namespace: "soltidtabellen"

k: CueExport: "homelab-soltidtabellen": spec: {
	interval:  "30m"
	sourceRef: _homelab
	paths: ["./resources/soltidtabellen"]
	prune:   true
	suspend: false
}
