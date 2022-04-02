package kube

k: GitRepository: "kube-vip-cloud-provider": spec: {
	interval: "1h"
	ref: tag: "0.1"
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
	patches: [{
		target: {
			group:   "apps"
			version: "v1"
			kind:    "StatefulSet"
			name:    "cloud-provider"
		}
		patch: """
			- op: replace
			  path: /spec/template/spec/containers/0/imagePullPolicy
			  value: IfNotPresent
			"""
	}]
}
