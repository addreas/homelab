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

k: GitRepository: "cue-flux-controller": spec: {
	ref: branch: "main"
	url: "https://github.com/addreas/cue-flux-controller"
}

k: Kustomization: "cue-flux-controller": spec: {
	path:  "./config/default"
	prune: false // dont prune this either
	images: [{
		name:    "phoban01/cue-controller"
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
