package kube

import "strings"

k: HelmRepository: longhorn: spec: url: "https://charts.longhorn.io"

k: HelmRelease: longhorn: spec: {
	chart: spec: version: strings.TrimPrefix(githubReleases["longhorn/longhorn"], "v")
	values: {
		csi: kubeletRootDir: "/var/lib/kubelet"
		defaultSettings: {
			autoSalvage:                          true
			allowNodeDrainWithLastHealthyReplica: true
		}

		persistence: defaultClassReplicaCount: 2
		defaultSettings: backupTarget:         "nfs://nucles.localdomain:/export/longhorn-backup"
	}
}

k: GitRepository: "external-snapshotter": spec: {
	ref: branch: "master"
	url: "https://github.com/kubernetes-csi/external-snapshotter"
	ignore: """
		/*
		!/client/config/
		"""
}

k: Kustomization: "external-snapshotter": spec: path: "./client/config/crd"
