package kube

k: HelmRepository: kured: {
	metadata: namespace: "kube-system"
	spec: {
		interval: "1h"
		url:      "https://weaveworks.github.io/kured"
	}
}

k: HelmRelease: kured: {
	metadata: namespace: "kube-system"
	spec: {
		interval: "1h"
		chart: spec: {
			chart:   "kured"
			version: "2.3.2"
			sourceRef: {
				kind:      "HelmRepository"
				name:      "kured"
				namespace: "kube-system"
			}
			interval: "1h"
		}
		values: {
			configuration: {
				lockTtl: "3h"
				period:  "10m"
			}
			metrics: create: true
		}
	}
}
