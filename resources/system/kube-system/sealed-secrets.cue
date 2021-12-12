package kube

import (
	"strings"
	"github.com/addreas/homelab/util"
)

k: HelmRepository: "sealed-secrets": spec: {
	interval: "1h"
	url:      "https://bitnami-labs.github.io/sealed-secrets"
}

k: HelmRelease: "sealed-secrets-controller": spec: {
	interval: "1h"
	chart: spec: {
		chart:   "sealed-secrets"
		version: strings.TrimPrefix(util.goModVersions["github.com/bitnami-labs/sealed-secrets"], "v")
		sourceRef: {
			kind:      "HelmRepository"
			name:      "sealed-secrets"
			namespace: "kube-system"
		}
		interval: "1h"
	}
}
