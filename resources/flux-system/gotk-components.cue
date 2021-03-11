package kube

k: Namespace: "flux-system": {}

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
