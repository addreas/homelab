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
	ref: tag: "v0.18.2-cue"
	url: "https://github.com/addreas/cue-controller"
}

k: Kustomization: "cuebuild-controller": spec: {
	path:  "./config/default"
	prune: false // dont prune this either
	images: [{
		name:   "ghcr.io/addreas/cuebuild-controller"
		newTag: "v0.18.2"
	}]
}

k: GitRepository: "cue-controller": spec: {
	ref: tag: "v0.35.0-cue-2"
	url: "https://github.com/addreas/cue-controller"
}

k: Kustomization: "cue-controller": spec: {
	path:  "./config/default"
	prune: false // dont prune this either
	images: [{
		name:   "ghcr.io/addreas/cue-controller"
		newTag: "v0.35.0"
	}]
}

k: GitRepository: "cue-flux-controller": spec: {
	ref: branch: "main"
	url: "https://github.com/addreas/cue-flux-controller"
}

k: Kustomization: "cue-flux-controller": spec: {
	path:  "./config/default"
	prune: false // dont prune this either
	images: [{
		name:    "ghcr.io/phoban01/cue-controller"
		newName: "ghcr.io/addreas/cue-flux-controller"
		newTag:  "latest"
	}]
}

k: Ingress: "flux-webhook": spec: rules: [{
	http: paths: [{
		backend: service: {
			name: "webhook-receiver"
			port: name: "http"
		}
	}]
}]
