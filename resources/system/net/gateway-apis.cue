package kube

k: GitRepository: "gateway-api-crds": spec: {
	ref: tag: "v1.5.1" // TODO: renovate
	url: "https://github.com/kubernetes-sigs/gateway-api"
	ignore: """
		/*
		!/config/crd.yml
		"""
}

k: Kustomization: "gateway-api-crds": spec: path: "./config/crd"
