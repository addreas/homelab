package kube

k: HelmRepository: "cert-manager": spec: url: "https://charts.jetstack.io"

k: HelmRelease: "cert-manager": spec: {
	chart: spec: {
		chart:   "cert-manager"
		version: "v1.21.1"
	}
	values: {
		crds: enabled:            true
		config: enableGatewayAPI: true
	}
}
