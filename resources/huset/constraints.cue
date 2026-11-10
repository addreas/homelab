package kube

_namespace: "huset"

k: CueExport: "homelab-huset": spec: {
	paths: ["./resources/huset"]
	prune:   true
	suspend: false
}
