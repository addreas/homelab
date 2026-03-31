package kube

k: HelmRepository: cilium: spec: url: "https://helm.cilium.io/"

k: HelmRelease: cilium: spec: {
	chart: spec: version: "1.19.2" // TODO: renovate?
	values: {
		cni: exclusive: false

		k8sServiceHost: "localhost"
		k8sServicePort: 7445
		securityContext: capabilities: {
			ciliumAgent: ["CHOWN", "KILL", "NET_ADMIN", "NET_RAW", "IPC_LOCK", "SYS_ADMIN", "SYS_RESOURCE", "DAC_OVERRIDE", "FOWNER", "SETGID", "SETUID"]
			cleanCiliumState: ["NET_ADMIN", "SYS_ADMIN", "SYS_RESOURCE"]
		}
		cgroup: {
			autoMount: enabled: false
			hostRoot: "/sys/fs/cgroup"
		}

		kubeProxyReplacement: true
		ipam: mode:      "kubernetes"
		bpf: masquerade: true

		gatewayAPI: enabled:      true
		l2announcements: enabled: true
		bgpControlPlane: enabled: true

		ingressController: enabled:          true
		ingressController: loadbalancerMode: "shared"
	}
}
