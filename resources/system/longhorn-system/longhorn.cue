package kube

import "strings"

import "encoding/yaml"

k: Namespace: "longhorn-system": {}

k: HelmRepository: longhorn: {
	spec: {
		url: "https://charts.longhorn.io"
	}
}

k: HelmRelease: longhorn: spec: {
	chart: spec: {
		version: strings.TrimPrefix(githubReleases["longhorn/longhorn"], "v")
	}
	values: {
		csi: kubeletRootDir: "/var/lib/kubelet"
		defaultSettings: {
			autoSalvage:                          true
			allowNodeDrainWithLastHealthyReplica: true
		}

		persistence: defaultClassReplicaCount: 2
		image: longhorn: {
			manager: {
				repository: "ghcr.io/addreas/longhorn-manager"
				tag:        githubReleases["longhorn/longhorn"]
			}
			instanceManager: {
				repository: "ghcr.io/addreas/longhorn-instance-manager"
				tag:        githubReleases["longhorn/longhorn"]
			}
		}

		defaultSettings: backupTarget: "nfs://nucles.localdomain:/export/longhorn-backup"
	}
	postRenderers: [{
		kustomize: patches: [{
			target: {
				group:     "apps"
				kind:      "DaemonSet"
				name:      "longhorn-manager"
				namespace: "longhorn-system"
			}

			patch: yaml.Marshal({
				apiVersion: "apps/v1"
				kind:       "DaemonSet"
				metadata: {
					name:      "longhorn-manager"
					namespace: "longhorn-system"
				}
				spec: template: spec: containers: [{
					name: "longhorn-manager"
					env: [{
						name:  "PATH"
						value: "/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/run/wrappers/bin:/nix/var/nix/profiles/default/bin:/run/current-system/sw/bin"
					}]
				}]
			})
		},
		]
	}]
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
