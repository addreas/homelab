package kube

import "strings"

k: HelmRepository: kured: spec: url: "https://kubereboot.github.io/charts"

k: HelmRelease: kured: spec: {
	chart: spec: {
		version: strings.TrimPrefix(githubReleases["kubereboot/charts"], "kured-")
	}
	values: {
		metrics: create: true
		configuration: {
			rebootDays: ["sa"]
			startTime: "08:00"
			endTime:   "22:00"
			// notifyUrl: "http://user:pass@ntfy.default.svc:8080/kured"
		}
		extraEnvVars: [{
			name: "PATH"
			value: "/run/wrappers/bin:/nix/var/nix/profiles/default/bin:/run/current-system/sw/bin"
		}]
	}
}
