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
			version: ">= 2.4.0"
			sourceRef: {
				kind:      "HelmRepository"
				name:      "kured"
				namespace: "kube-system"
			}
			interval: "1h"
		}
		values: {
			metrics: create: true
			configuration: {
				rebootDays: ["sa"]
				startTime: "10:00"
				endTime: "16:00"
			}
		}
	}
}
