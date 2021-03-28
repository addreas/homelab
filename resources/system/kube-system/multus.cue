package kube

k: GitRepository: "multus-cni": spec: {
	interval: "1h"
	ref: branch: "master"
	url: "https://github.com/k8snetworkplumbingwg/multus-cni"
	ignore: """
		/*
		!/images/multus-daemonset.yml
		"""
}

k: Kustomization: "multus-cni": spec: {
	interval: "1h"
	path:     "./images"
	prune:    true
	sourceRef: {
		kind: "GitRepository"
		name: "multus-cni"
	}
	validation: "client"
}
