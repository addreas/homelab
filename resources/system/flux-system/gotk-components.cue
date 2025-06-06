package kube

import "encoding/yaml"

k: GitRepository: "flux-components": spec: {
	ref: tag: otherTags["fluxcd/flux2"]
	url: "https://github.com/fluxcd/flux2"
}

k: Kustomization: "flux-components": spec: {
	path:  "./manifests/install"
	prune: false // if this gets pruned things get messy
}

k: GitRepository: "cue-controller": spec: {
	ref: branch: "main"
	url: "https://github.com/addreas/cue-controller"
}

k: Kustomization: "cue-controller": spec: {
	path:  "./config/default"
	prune: false // dont prune this either
	images: [{
		name:   "ghcr.io/addreas/cue-controller"
		newTag: "v1.4.0"
	}]
	patches: [{
		patch: yaml.Marshal({
			apiVersion: "apps/v1"
			kind:       "Deployment"
			metadata: {
				name: "cue-controller"
			}
			spec: template: spec: containers: [{
				name: "manager"
				// imagePullPolicy: "Always"
				args: [
					"--concurrent=1",
					"--log-level=info",
					// "--log-encoding=console",
					"--watch-all-namespaces",
					"--enable-leader-election",
				]
			}]
		})
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
