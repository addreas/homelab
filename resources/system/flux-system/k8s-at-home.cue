package kube

k: HelmRepository: "k8s-at-home": spec: {
	interval: "1h"
	url:      "https://k8s-at-home.com/charts/"
}
