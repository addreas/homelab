package kube

k: GitRepository: homelab: spec: {
	interval: "1h"
	ref: branch: "main"
	url: "https://github.com/addreas/homelab"
}

k: Kustomization: kpack: spec: {
	interval: "1h"
	path:     "./resources/system/kpack"
	prune:    true
	sourceRef: {
		kind: "GitRepository"
		name: "homelab"
	}
	validation: "client"
	patchesStrategicMerge: [{
		apiVersion: "v1"
		kind:       "ConfigMap"
		metadata: {
			name:      "lifecycle-image"
			namespace: "kpack"
		}
		data: image: "ghcr.io/addreas/kpack-lifecycle@sha256:db90b57428b6a711611acfb2b8c8a74e2bd3ebca60c46ef335853cd437450920"
	}]
}

k: ServiceAccount: "test-service-account": {
	secrets: [{
		name: "registry-credentials"
	}]
	imagePullSecrets: [{
		name: "registry-credentials"
	}]
}

k: ClusterStore: default: spec: sources: [{
	image: "gcr.io/paketo-buildpacks/nodejs"
}]

k: ClusterStack: base: spec: {
	id: "io.buildpacks.stacks.bionic"
	buildImage: image: "paketobuildpacks/build:base-cnb"
	runImage: image:   "paketobuildpacks/run:base-cnb"
}

k: Builder: "test-builder": spec: {
	serviceAccount: "test-service-account"
	tag:            "registry.addem.se/kpack/test-builder"
	stack: {
		name: "base"
		kind: "ClusterStack"
	}
	store: {
		name: "default"
		kind: "ClusterStore"
	}
	order: [{
		group: [{
			id: "paketo-buildpacks/nodejs"
		}]
	}]
}

k: Image: "test-image": spec: {
	tag:            "registry.addem.se/kpack/test-image"
	serviceAccount: "test-service-account"
	builder: {
		name: "test-builder"
		kind: "Builder"
	}
	source: git: {
		url:      "https://github.com/shapeshed/express_example"
		revision: "3de0ae190114ad8b42434170f57146ba9e700d32"
	}
}
