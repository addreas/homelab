package kube

k: HelmRepository: "sealed-secrets": spec: url: "https://bitnami-labs.github.io/sealed-secrets"

k: HelmRelease: "sealed-secrets-controller": spec: chart: spec: {
	chart:   "sealed-secrets"
	version: "2.7.4"
	sourceRef: name: "sealed-secrets"
}
