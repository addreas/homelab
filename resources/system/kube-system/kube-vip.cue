package kube

k: GitRepository: "kube-vip-cloud-provider": spec: {
	ref: branch: "main"
	url: "https://github.com/kube-vip/kube-vip-cloud-provider"
	ignore: """
		/*
		!/manifest
		"""
}

k: Kustomization: "kube-vip-cloud-provider": spec: path: "./manifest"
