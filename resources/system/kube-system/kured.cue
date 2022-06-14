package kube

k: HelmRepository: kured: {
	spec: {
		interval: "1h"
		url:      "https://weaveworks.github.io/kured"
	}
}

k: HelmRelease: kured: {
	spec: {
		interval: "1h"
		chart: spec: {
			chart: "kured"
			// TODO: version bump tool
			version: "2.11.0"
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
				startTime: "08:00"
				endTime:   "22:00"
			}
		}
	}
}
