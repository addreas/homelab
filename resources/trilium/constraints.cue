package kube

k: [string]: [string]: metadata: namespace: *"trilium" | string

k: Namespace: "trilium": {}

k: CueExport: "homelab-trilium": spec: {
	interval:  "30m"
	sourceRef: _homelab
	paths: ["./resources/trilium"]
	prune:   true
	suspend: false
}
