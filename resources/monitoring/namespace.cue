package kube

k: Namespace: monitoring: {}

k: [string]: [string]: metadata: namespace: *"monitoring" | string
