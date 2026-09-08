package kube

_namespace: "cnpg-system"

k: HelmRepository: "cloudnative-pg": spec: url: "https://cloudnative-pg.github.io/charts"

k: HelmRelease: "cloudnative-pg": spec: {
	chart: spec: {
		chart:   "cloudnative-pg"
		version: "v0.27.1"
	}
}
