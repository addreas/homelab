package kube

k: GitRepository: "flux-components": spec: {
	interval: "1h"
	ref: branch: "main"
	url: "https://github.com/fluxcd/flux2"
}

k: Kustomization: "flux-components": spec: {
	interval: "1h"
	path:     "./manifests/install"
	prune:    false // if this gets pruned things get messy
	sourceRef: {
		kind: "GitRepository"
		name: "flux-components"
	}
}

k: GitRepository: "cuebuild-controller": spec: {
	interval: "1h"
	ref: branch: "main"
	url: "https://github.com/addreas/cuebuild-controller"
}

k: Kustomization: "cuebuild-controller": spec: {
	interval: "1h"
	path:     "./config/default"
	prune:    false // dont prune this either
	sourceRef: {
		kind: "GitRepository"
		name: "cuebuild-controller"
	}
	images: [{
		name:   "ghcr.io/addreas/cuebuild-controller"
		newTag: "v0.18.2"
	}]
}
