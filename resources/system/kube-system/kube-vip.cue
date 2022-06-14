package kube

k: GitRepository: "kube-vip-cloud-provider": spec: {
	interval: "1h"
	ref: branch: "main"
	url: "https://github.com/kube-vip/kube-vip-cloud-provider"
	ignore: """
		/*
		!/manifest
		"""
}

k: Kustomization: "kube-vip-cloud-provider": spec: {
	interval: "1h"
	path:     "./manifest"
	sourceRef: {
		kind: "GitRepository"
		name: "kube-vip-cloud-provider"
	}
}
