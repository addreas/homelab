package kube

k: CueExport: [Name=string]: spec: {
	interval: _ | *"30m"
	sourceRef: _ | *{
		kind:      "GitRepository"
		name:      "homelab"
		namespace: "flux-system"
	}
}

k: GitRepository: [string]: spec: interval: _ | *"1h"

k: HelmRepository: [string]: spec: interval: _ | *"1h"

k: HelmRelease: [Name=string]: {
	metadata: namespace: string
	spec: {
		interval: _ | *"1h"
		chart: spec: {
			interval: _ | *"1h"
			sourceRef: _ | *{
				kind:      "HelmRepository"
				name:      _ | *Name
				namespace: _ | *metadata.namespace
			}
		}
	}
}

k: Kustomization: [Name=string]: spec: {
	interval: _ | *"1h"
	prune:    _ | *true
	sourceRef: _ | *{
		kind: "GitRepository"
		name: _ | *Name
	}
}
