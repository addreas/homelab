package kube

import "github.com/addreas/homelab/util"

k: HelmRepository: cilium: spec: {
	interval: "1h"
	url:      "https://helm.cilium.io/"
}

k: HelmRelease: cilium: spec: {
	interval: "1h"
	chart: spec: {
		chart:   "cilium"
		version: util.goModVersions["github.com/cilium/cilium"]
		sourceRef: {
			kind:      "HelmRepository"
			name:      "cilium"
			namespace: "kube-system"
		}
		interval: "1h"
	}
	values: cni: exclusive: false
}
