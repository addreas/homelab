package kube

// k: GitRepository: homelab: spec: {
// 	interval: "1h"
// 	ref: branch: "main"
// 	url: "https://github.com/addreas/homelab"
// }

// k: Kustomization: kpack: spec: {
// 	interval: "1h"
// 	path:     "./resources/system/kpack"
// 	prune:    true
// 	sourceRef: {
// 		kind: "GitRepository"
// 		name: "homelab"
// 	}
// 	validation: "client"
// 	patchesStrategicMerge: [{
// 		apiVersion: "v1"
// 		kind:       "ConfigMap"
// 		metadata: {
// 			name:      "lifecycle-image"
// 			namespace: "kpack"
// 		}
// 		data: image: "ghcr.io/addreas/kpack-lifecycle@sha256:db90b57428b6a711611acfb2b8c8a74e2bd3ebca60c46ef335853cd437450920"
// 	}, {
// 		apiVersion: "apps/v1"
// 		kind: "Deployment"
// 		metadata: {
// 			name: "kpack-controller"
// 			namespace: "kpack"
// 		}
// 		spec: template: spec: containers: [{
// 			name: "controller"
// 			image: "gcr.io/cf-build-service-public/kpack/controller@sha256:28048eeea9f7b2a1d15cf6b13e8f326376f17b934e31b3aedecf2e3ee8dd1d94"
// 		}]
// 	}, {
// 		apiVersion: "apps/v1"
// 		kind: "Deployment"
// 		metadata: {
// 			name: "kpack-webhook"
// 			namespace: "kpack"
// 		}
// 		spec: template: spec: containers: [{
// 			name: "webhook"
// 			image: "gcr.io/cf-build-service-public/kpack/webhook@sha256:305750b32736adef29d8e8b45eea956bab402d4e4ac4ad81cc930a4f078c3f57"
// 		}]
// 	}]
// }

k: ServiceAccount: "test-service-account": {
	secrets: [{
		name: "registry-credentials"
	}]
	imagePullSecrets: [{
		name: "registry-credentials"
	}]
}

k: ClusterStore: default: spec: {
	serviceAccountRef: {
		name: "test-service-account"
		namespace: "kpack"
	}
	sources: [{
		image: "gcr.io/paketo-buildpacks/nodejs"
	}, {
		image: "ghcr.io/addreas/elixir-buildpack"
	}]
}

k: ClusterStack: "full-cnb": spec: {
	id: "io.buildpacks.stacks.bionic"
	buildImage: image: "paketobuildpacks/build:full-cnb"
	runImage: image:   "paketobuildpacks/run:full-cnb"
}
