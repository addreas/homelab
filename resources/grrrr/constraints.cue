package kube

k: [string]: [string]: metadata: {
	namespace: *"grrrr" | string
}

k: StatefulSet: [string]: spec: replicas: 0

k: CueExport: "homelab-grrrr": spec: {
	interval:  "30m"
	sourceRef: _homelab
	paths: ["./resources/grrrr"]
	prune:   true
	suspend: false
}
