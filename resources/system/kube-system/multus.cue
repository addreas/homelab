package kube

import "encoding/yaml"

k: GitRepository: "multus-cni": spec: {
	interval: "1h"
	ref: tag: "v3.8"
	url: "https://github.com/k8snetworkplumbingwg/multus-cni"
	ignore: """
		/*
		!/images/multus-daemonset.yml
		"""
}

k: Kustomization: "multus-cni": spec: {
	interval: "1h"
	path:     "./images"
	prune:    true
	sourceRef: {
		kind: "GitRepository"
		name: "multus-cni"
	}
	images: [{
		name:   "ghcr.io/k8snetworkplumbingwg/multus-cni"
		newTag: "stable@sha256:9479537fe0827d23bc40056e98f8d1e75778ec294d89ae4d8a62f83dfc74a31d"
	}]
	patches: [{
		target: {
			group:     "apps"
			version:   "v1"
			kind:      "DaemonSet"
			name:      "kube-multus-ds"
			namespace: "kube-system"
		}
		patch: yaml.Marshal({
			apiVersion: "apps/v1"
			kind:       "DaemonSet"
			metadata: {
				name:      "kube-multus-ds"
				namespace: "kube-system"
			}
			spec: template: spec: {
				containers: [{
					name: "kube-multus"
					args: [
						"--multus-conf-file=auto",
						"--cni-version=0.3.1",
						"--restart-crio=true",
					]
					volumeMounts: [{
						name:      "run"
						mountPath: "/run"
					}]
				}]
				volumes: [{
					name: "run"
					hostPath: path: "/run"
				}]
			}
		})
	}]
}
