package kube

_namespace: "trilium"

k: CueExport: "homelab-trilium": spec: {
	paths: ["./resources/trilium"]
	prune:   true
	suspend: false
}
