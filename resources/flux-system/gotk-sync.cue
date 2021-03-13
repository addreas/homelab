package kube

k: GitRepository: "homelab": spec: {
	interval: "5m0s"
	ref: branch: "main"
	url: "https://github.com/addreas/homelab"
}

k: CueBuild: "homelab": spec: {
	interval: "5m0s"
	healthChecks: [{
		kind:      "StatefulSet"
		name:      "bitwarden"
		namespace: "default"
	}, {
		kind:      "StatefulSet"
		name:      "unifi-controller"
		namespace: "default"
	}]
	packages: [
		"./resources/bitwarden",
		"./resources/default",
		"./resources/flux-system",
		"./resources/grrrr",
		"./resources/kube-system",
		"./resources/longhorn-system",
		"./resources/monitoring",
		"./resources/unifi",
	]
	prune: true
	sourceRef: {
		kind: "GitRepository"
		name: "homelab"
	}
	validation: "client"
}
