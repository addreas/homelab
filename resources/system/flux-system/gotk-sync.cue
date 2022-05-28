package kube

k: GitRepository: "homelab": spec: {
	interval: "1m0s"
	ref: branch: "main"
	url: "https://github.com/addreas/homelab"
}

k: CueBuild: "homelab-system": spec: {
	interval: "30m"
	packages: [
		"./resources/system/cert-manager",
		"./resources/system/flux-system",
		"./resources/system/kube-system",
		"./resources/system/longhorn-system",
		"./resources/system/monitoring",
	]
	prune:     false
	sourceRef: _homelab
}
