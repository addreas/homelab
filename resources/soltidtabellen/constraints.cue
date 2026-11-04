package kube

_namespace: "soltidtabellen"

k: CueExport: "homelab-soltidtabellen": spec: {
	paths: ["./resources/soltidtabellen"]
	prune:   true
	suspend: false
}
