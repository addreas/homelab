package kube

k: Namespace: "longhorn-system": {}

k: HelmRepository: longhorn: {
	spec: {
		interval: "1h"
		url:      "https://charts.longhorn.io"
	}
}

k: HelmRelease: longhorn: spec: {
	interval: "1h"
	chart: spec: {
		chart:   "longhorn"
		version: "1.2.3"
		sourceRef: {
			kind:      "HelmRepository"
			name:      "longhorn"
			namespace: "longhorn-system"
		}
		interval: "1h"
	}
	values: {
		csi: kubeletRootDir: "/var/lib/kubelet"
		defaultSettings: {
			autoSalvage:                          true
			allowNodeDrainWithLastHealthyReplica: true
		}
		persistence: defaultClassReplicaCount: 2
	}
}
