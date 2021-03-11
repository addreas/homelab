package kube

k: GitRepository: "homelab": spec: {
	interval: "5m0s"
	ref: branch: "main"
	url: "https://github.com/addreas/homelab"
}

k: CueBuild: "homelab": spec: {
	interval: "5m0s"
	packages: [
		"./resources/...",
	]
	prune: true
	sourceRef: {
		kind: "GitRepository"
		name: "homelab"
	}
	validation: "client"
}
