package kube

k: CueBuild: "periserve": spec: {
	interval: "1h"
	packages: ["./resources/periserve/..."]
	prune: false
    
    // Set to true to disable auto-deploy
    suspend: false

	sourceRef: {
		kind: "GitRepository"
		name: "homelab"
        namespace: "flux-system"
	}
}