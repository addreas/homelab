package kube

k: HelmRepository: "prometheus-community": spec: url: "https://prometheus-community.github.io/helm-charts"

k: HelmRelease: "prometheus-operator-crds": spec: chart: spec: {
	chart:   "prometheus-operator-crds"
	version: "32.0.1"
	sourceRef: name: "prometheus-community"
}
