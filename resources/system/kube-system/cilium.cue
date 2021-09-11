package kube

k: HelmRepository: cilium: {
	spec: {
		interval: "1h"
		url:      "https://helm.cilium.io/"
	}
}

k: HelmRelease: cilium: {
	spec: {
		interval: "1h"
		chart: spec: {
			chart:   "cilium"
			version: "v1.10.4"
			sourceRef: {
				kind:      "HelmRepository"
				name:      "cilium"
				namespace: "kube-system"
			}
			interval: "1h"
		}
	}
}
