package kube

k: HelmRepository: "bitnami": spec: {
	interval: "1h"
	url:      "https://charts.bitnami.com/bitnami"
}

k: HelmRelease: "metallb": {
	spec: {
		interval: "1h"
		chart: spec: {
			chart:   "metallb"
			version: ">= 2.3.4"
			sourceRef: {
				kind:      "HelmRepository"
				name:      "bitnami"
				namespace: "metallb-system"
			}
			interval: "1h"
		}
		values: {
			configInline: "address-pools": [{
				name:     "default"
				protocol: "layer2"
				addresses: ["192.168.1.6-192.168.1.50"]
			}]
			prometheusRule: enabled: true
			controller: prometheus: serviceMonitor: enabled: true
			speaker: prometheus: serviceMonitor: enabled:    true
		}
	}
}
