package kube

import "github.com/addreas/homelab/util"

k: Namespace: "metallb-system": {}

k: [string]: [string]: metadata: namespace: "metallb-system"

k: util.prometheusNamespaceRBAC
