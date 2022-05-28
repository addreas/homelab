package kube

k: [string]: [string]: metadata: {
	namespace: *"grrrr" | string
}

k: CueBuild: "homelab": spec: {
	interval: "15m0s"
	sourceRef: {
		kind: "GitRepository"
		name: "homelab"
		namespace: "flux-system"
	}
	packages: ["./resources/grrrr"]
	prune: true
}
