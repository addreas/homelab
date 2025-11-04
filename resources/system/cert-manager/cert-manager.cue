package kube

k: HelmRepository: "cert-manager": spec: {
	url: "https://charts.jetstack.io"
}

k: HelmRelease: "cert-manager": spec: {
	chart: spec: {
		version: githubReleases["cert-manager/cert-manager"]
	}
	values: installCRDs: true
}
