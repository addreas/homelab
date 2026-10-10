package kube

k: HelmRepository: grafana: spec: url: "https://grafana.github.io/helm-charts/"

k: HelmRelease: "grafana-operator": spec: chart: spec: {
	chart:   "grafana-operator"
	version: "5.25.0"
	sourceRef: name: "grafana"
}
