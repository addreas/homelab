package kube

k: HelmRepository: kured: spec: url: "https://weaveworks.github.io/kured"

k: HelmRelease: kured: spec: {
	chart: spec: {
		// TODO: version bump tool
		version: "2.11.0"
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
