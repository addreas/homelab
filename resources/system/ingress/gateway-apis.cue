package kube

k: GitRepository: "gateway-api-crds": spec: {
	url: "https://github.com/kubernetes-sigs/gateway-api"
	ref: tag: "v1.6.1"
	ignore: """
		/*
		!/config/crd
		"""
}

k: Kustomization: "gateway-api-crds": spec: path: "./config/crd/experimental"
