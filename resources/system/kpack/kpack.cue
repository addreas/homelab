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
	image: "gcr.io/paketo-buildpacks/java"
}, {
	image: "gcr.io/paketo-buildpacks/nodejs"
}]

k: ClusterStack: base: spec: {
	id: "io.buildpacks.stacks.bionic"
	buildImage: image: "paketobuildpacks/build:base-cnb"
	runImage: image:   "paketobuildpacks/run:base-cnb"
}

k: Builder: "my-builder": spec: {
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
			id: "paketo-buildpacks/java"
		}]
	}, {
		group: [{
			id: "paketo-buildpacks/nodejs"
		}]
	}]
}

k: Image: "test-image": spec: {
	tag:            "registry.adde.se/kpack/test-image"
	serviceAccount: "test-service-account"
	builder: {
		name: "my-builder"
		kind: "Builder"
	}
	source: git: {
		url:      "https://github.com/spring-projects/spring-petclinic"
		revision: "82cb521d636b282340378d80a6307a08e3d4a4c4"
	}
}

k: Pod: "kp": spec: containers: [{
	name: "kp"
	image: "kpack/kp"
	command: ["sleep", "10000"]
}]
