package kube

k: GitRepository: "flux-components": spec: {
	ref: branch: "main"
	url: "https://github.com/fluxcd/flux2"
}

k: Kustomization: "flux-components": spec: {
	path:  "./manifests/install"
	prune: false // if this gets pruned things get messy
}

k: GitRepository: "cuebuild-controller": spec: {
	ref: branch: "main"
	url: "https://github.com/addreas/cuebuild-controller"
}

k: Kustomization: "cuebuild-controller": spec: {
	path:  "./config/default"
	prune: false // dont prune this either
	images: [{
		name:   "ghcr.io/addreas/cuebuild-controller"
		newTag: "v0.18.2"
	}]
}
