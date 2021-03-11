package kube

k: HelmRepository: cilium: {
	metadata: namespace: "kube-system"
	spec: {
		interval: "1h"
		url:      "https://helm.cilium.io/"
	}
}

k: HelmRelease: cilium: {
	metadata: namespace: "kube-system"
	spec: {
		interval: "1h"
		chart: spec: {
			chart:   "cilium"
			version: "v1.9.4"
			sourceRef: {
				kind:      "HelmRepository"
				name:      "cilium"
				namespace: "kube-system"
			}
			interval: "1h"
		}
		values: {
			prometheus: {
				enabled: true
				serviceMonitor: enabled: true
			}
			operator: prometheus: {
				enabled: true
				serviceMonitor: enabled: true
			}
			hubble: metrics: {
				enabled: [
					"dns:query;ignoreAAAA",
					"drop",
					"tcp",
					"flow",
					"icmp",
					"http",
				]
				serviceMonitor: enabled: true
			}
		}
		postRenderers: [{
			kustomize: patchesStrategicMerge: [{
				apiVersion: "monitoring.coreos.com/v1"
				kind:       "ServiceMonitor"
				metadata: {
					name:      "cilium-agent"
					namespace: "kube-system"
				}
				spec: targetLabels: ["k8s-app"]
			}, {
				apiVersion: "monitoring.coreos.com/v1"
				kind:       "ServiceMonitor"
				metadata: {
					name:      "cilium-operator"
					namespace: "kube-system"
				}
				spec: targetLabels: ["io.cilium/app"]
			}]
		}]
	}
}
