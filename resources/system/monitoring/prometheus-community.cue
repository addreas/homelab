package kube

k: HelmRepository: "prometheus-community": spec: {
	interval: "1h"
	url:      "https://prometheus-community.github.io/helm-charts"
}
