package kube

k: GitRepository: homelab: spec: {
	interval: "1h"
	ref: branch: "main"
	url: "https://github.com/addreas/homelab"
}

k: Kustomization: kpack: spec: {
	interval: "1h"
	path:     "./resources/system/kpack"
	sourceRef: {
		kind: "GitRepository"
		name: "homelab"
	}
}

k: ServiceAccount: "cluster-store-default": {
	secrets: [{
		name: "registry-credentials"
	}]
	imagePullSecrets: [{
		name: "registry-credentials"
	}]
}

k: ClusterStore: default: spec: {
	serviceAccountRef: {
		name:      "cluster-store-default"
		namespace: "kpack"
	}
	sources: [{
		image: "gcr.io/paketo-buildpacks/nodejs"
	}, {
		image: "ghcr.io/addreas/elixir-buildpack"
	}, {
		image: "ghcr.io/addreas/fwup-buildpack"
	}]
}

k: ClusterStack: "full-cnb": spec: {
	id: "io.buildpacks.stacks.bionic"
	buildImage: image: "paketobuildpacks/build:full-cnb"
	runImage: image:   "paketobuildpacks/run:full-cnb"
}
