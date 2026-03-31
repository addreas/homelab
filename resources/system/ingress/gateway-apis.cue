package kube

k: GitRepository: "gateway-api-crds": spec: {
	ref: tag: "v1.4.1" // TODO: renovate
	url: "https://github.com/kubernetes-sigs/gateway-api"
	ignore: """
		/*
		!/config/crd
		"""
}

k: Kustomization: "gateway-api-crds": spec: path: "./config/crd"
