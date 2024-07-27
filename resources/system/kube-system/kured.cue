package kube

import "strings"

k: HelmRepository: kured: spec: url: "https://kubereboot.github.io/charts"

k: HelmRelease: kured: spec: {
	chart: spec: version: strings.TrimPrefix(githubReleases["kubereboot/charts"], "kured-")
	values: {
		metrics: create: true
		configuration: {
			forceReboot:  true
			drainTimeout: "5m"
			rebootDays: ["sa"]
			startTime:    "08:00"
			endTime:      "22:00"
			rebootMethod: "signal"
		}
		containerSecurityContext: {
			privileged:               false
			readOnlyRootFilesystem:   true
			allowPrivilegeEscalation: false
			capabilities: {
				add: ["CAP_KILL"]
				// drop: ["ALL"]
			}
		}
	}
}
