package kube

k: GitRepository: "multus-cni": spec: {
	interval: "1h"
	ref: tag: "v3.7.2"
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
