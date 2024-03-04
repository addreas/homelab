package kube

k: [string]: [string]: metadata: namespace: *"splitplace" | string

k: CueExport: "homelab-splitplace": spec: {
	interval:  "30m"
	sourceRef: _homelab
	paths: ["./resources/splitplace"]
	prune:   true
	suspend: false
}

_DeploymentRestarter & {
	_name: "splitplace"
	_labelSelector: "app=splitplace"
}
