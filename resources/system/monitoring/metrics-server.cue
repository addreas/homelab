package kube

k: HelmRepository: "metrics-server": spec: {
	interval: "1h"
	url:      "https://kubernetes-sigs.github.io/metrics-server/"
}

k: HelmRelease: "metrics-server": spec: chart: spec: version: "3.7.0"
