package kube

import "strings"

k: HelmRepository: longhorn: spec: url: "https://charts.longhorn.io"

k: HelmRelease: longhorn: spec: {
	chart: spec: version: strings.TrimPrefix(githubReleases["longhorn/longhorn"], "v")
	values: {
		csi: kubeletRootDir: "/var/lib/kubelet"
		// global: tolerations: [{
		// 	key:    "node-role.kubernetes.io/control-plane"
		// 	effect: "NoSchedule"
		// }]
		defaultSettings: {
			defaultReplicaCount: 2
			replicaAutoBalance:  true
			autoSalvage:         true

			allowNodeDrainWithLastHealthyReplica: true

			backupTarget:                 "s3://Backups@us-east-1/longhorn"
			backupTargetCredentialSecret: "longhorn-backup-creds"

			createDefaultDiskLabeledNodes:  true
			v2DataEngine:                   true
			dataEngineInterruptModeEnabled: '{"v2": "true"}'
			defaultDataLocality:            "best-effort"
		}
		persistence: {
			dataEngine:               "v2"
			defaultClassReplicaCount: 2
			defaultDataLocality:      "best-effort"
		}
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
