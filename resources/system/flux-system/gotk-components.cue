package kube

k: GitRepository: "flux-components": spec: {
	interval: "1h"
	ref: branch: "main"
	url: "https://github.com/fluxcd/flux2"
}

k: Kustomization: "flux-components": spec: {
	interval: "1h"
	path:     "./manifests/install"
	prune:    true
	sourceRef: {
		kind: "GitRepository"
		name: "flux-components"
	}
	validation: "client"
}

k: GitRepository: "cuebuild-controller": spec: {
	interval: "1h"
	ref: branch: "main"
	url: "https://github.com/addreas/cuebuild-controller"
}

k: Kustomization: "cuebuild-controller": spec: {
	interval: "1h"
	path:     "./config/default"
	prune:    true
	sourceRef: {
		kind: "GitRepository"
		name: "cuebuild-controller"
	}
	validation: "client"
}
