package kube

_namespace: "splitplace"

k: CueExport: "homelab-splitplace": spec: {
	interval:  "30m"
	sourceRef: _homelab
	paths: ["./resources/splitplace"]
	prune:   true
	suspend: false
}

_deploymentRestarter & {
	_name:          "splitplace"
	_labelSelector: "app=splitplace"
}
