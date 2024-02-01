package kube

import "strings"

k: HelmRepository: kured: spec: url: "https://kubereboot.github.io/charts"

k: HelmRelease: kured: spec: {
	chart: spec: version: strings.TrimPrefix(githubReleases["kubereboot/charts"], "kured-")
	values: {
		metrics: create: true
		configuration: {
			rebootDays: ["sa"]
			startTime: "08:00"
			endTime:   "22:00"
			// notifyUrl: "http://user:pass@ntfy.default.svc:8080/kured"
			notifyUrl:    "generic+http://hass.default.svc.cluster.local:8123/api/webhook/kured-reboot"
			rebootMethod: "signal"
		}
		containerSecurityContext: {
			privileged:               false
			readOnlyRootFilesystem:   true
			allowPrivilegeEscalation: false
			capabilities: {
				add: ["CAP_KILL"]
				drop: ["ALL"]
			}
		}
	}
}
