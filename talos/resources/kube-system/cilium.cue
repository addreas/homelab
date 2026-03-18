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
		chart: spec: {
			chart:    "cilium"
			interval: "1h"
			sourceRef: {
				kind: "HelmRepository"
				name: "cilium"
			}
			version: "1.18.0"
		}
		interval: "1h"
		values: {
			cni: exclusive: false
			kubeProxyReplacement: true
			k8sServiceHost:       "localhost"
			k8sServicePort:       7445
			ipam: mode:      "kubernetes"
			bpf: masquerade: true
			securityContext: capabilities: {
				ciliumAgent: ["CHOWN", "KILL", "NET_ADMIN", "NET_RAW", "IPC_LOCK", "SYS_ADMIN", "SYS_RESOURCE", "DAC_OVERRIDE", "FOWNER", "SETGID", "SETUID"]
				cleanCiliumState: ["NET_ADMIN", "SYS_ADMIN", "SYS_RESOURCE"]
			}
			cgroup: {
				autoMount: enabled: false
				hostRoot: "/sys/fs/cgroup"
			}
		}
	}
}
