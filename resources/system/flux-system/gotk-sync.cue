package kube

k: GitRepository: "homelab": spec: {
	interval: "1m0s"
	ref: branch: "main"
	url: "https://github.com/addreas/homelab"
}

k: CueBuild: "homelab": spec: {
	interval: "5m0s"
	packages: [
		"./resources/bitwarden",
		"./resources/default",
		"./resources/fogis",
		"./resources/grrrr",
		"./resources/hass",
		"./resources/unifi",
		"./resources/system/cert-manager",
		"./resources/system/flux-system",
		"./resources/system/kube-system",
		"./resources/system/longhorn-system",
		"./resources/system/monitoring",
	]
	prune: true
	sourceRef: {
		kind: "GitRepository"
		name: "homelab"
	}
}
