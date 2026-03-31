package kube

import "encoding/yaml"

k: GitRepository: multus: spec: {
	ref: tag: "v4.2.4" // TODO: renovate
	url: "https://github.com/k8snetworkplumbingwg/multus-cni"
	ignore: """
		/*
		!/deployments/multus-daemonset.yml
		"""
}

k: Kustomization: multus: spec: {
	path: "./deployments"
	patches: [{
		target: kind: "DaemonSet"
		patch: yaml.Marshal({
			apiVersion: "batch/v1"
			kind:       "DaemonSet"
			metadata: name: "kube-multus-ds"
			spec: template: spec: {
				containers: [{
					name: "kube-multus"
					resources: limits: memory: "100Mi"
				}]
				volumes: [{
					name: "host-run-netns"
					hostPath: path: "/var/run/netns"
				}]
			}
		})
	}, {
		target: kind: "DaemonSet"
		patch: yaml.Marshal({
			apiVersion: "batch/v1"
			kind:       "DaemonSet"
			metadata: name: "kube-multus-ds"
			spec: template: spec: {
				containers: [{
					name: "kube-multus"
					volumeMounts: [{
						name:      "host-run-cni"
						mountPath: "/run/cni"
					}]
				}, {
					name:  "dhcp-daemon"
					image: "ghcr.io/addreas/cni-plugins:v1.9.1" // TODO: renovate
					command: [
						"/opt/cni/bin/dhcp",
						"daemon",
					]
					resources: limits: {
						cpu:    "100m"
						memory: "50Mi"
					}
					securityContext: privileged: true
					volumeMounts: [{
						name:      "host-run-cni"
						mountPath: "/run/cni"
					}, {
						name:             "host-run-netns"
						mountPath:        "/var/run/netns"
						mountPropagation: "HostToContainer"
					}]
				}]
				initContainers: [{
					name:  "install-cni-plugins"
					image: "ghcr.io/addreas/cni-plugins:v1.9.1" // TODO: renovate
					command: [
						"/bin/sh",
						"-c",
						"cp /opt/cni/bin/* /host/opt/cni/bin",
					]
					resources: limits: {
						cpu:    "100m"
						memory: "50Mi"
					}
					securityContext: privileged: true
					volumeMounts: [{
						name:             "cnibin"
						mountPath:        "/host/opt/cni/bin"
						mountPropagation: "Bidirectional"
					}]
				}]
				volumes: [{
					name: "host-run-cni"
					hostPath: path: "/run/cni"
				}]
			}
		})
	}]
}
