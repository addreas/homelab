package talos

t: Role: "control-plane": patches: [{
	machine: network: interfaces: [{
		deviceSelector: physical: true
		dhcp: true
		vip: ip: apiVip
	}]
	machine: certSANs: [apiHost, apiVip]
}, {
	apiVersion: "v1alpha1"
	kind:       "KubeTalosAPIAccessConfig"
	allowedRoles: ["os:operator"]
	allowedKubernetesNamespaces: ["kube-system"]
}, {
	apiVersion: "v1alpha1"
	kind:       "KubeProxyConfig"
	enabled:    false
}, {
	apiVersion: "v1alpha1"
	kind:       "KubeAPIServerConfig"
	extraArgs: "feature-gates": "MutablePVNodeAffinity=true"
}]

t: Role: "worker": patches: []

t: Role: "base": {
	patches: [{
		machine: features: diskQuotaSupport: true
	}, {
		apiVersion: "v1alpha1"
		kind:       "KubeNetworkConfig"
		dnsDomain:  "cluster.local"
		podSubnets: ["10.48.0.0/16"]
		serviceSubnets: ["10.96.0.0/12"]
	}, {
		apiVersion: "v1alpha1"
		kind:       "KubeFlannelCNIConfig"
		$patch:     "delete"
	}, {
		apiVersion: "v1alpha1"
		kind:       "ResolverConfig"
		hostDNS: forwardKubeDNSToHost: false // cilium issue: https://github.com/siderolabs/talos/pull/9200
	}, {
		apiVersion:                          "v1alpha1"
		kind:                                "KubeletConfig"
		defaultRuntimeSeccompProfileEnabled: true
	}, {
		apiVersion: "v1alpha1"
		kind:       "UnattendedInstallConfig"
		provisioning: {
			// diskSelector: match: #"(disk.size > 200u * GB) && (disk.size < 1000u * GB)"#
			diskSelector: match: #"disk.transport == "nvme" && disk.size < 1000u * GiB"#
			// diskSelector: match: #"disk.dev_path == "/dev/nvme1n1""#
			wipe: true
		}
	}, {
		apiVersion: "v1alpha1"
		kind:       "DiscoveryServiceConfig"
		name:       "default"
		$patch:     "delete"
	}]

	schematic: customization: {
		bootloader: "sd-boot"
		systemExtensions: officialExtensions: [
			"siderolabs/ctr",
			"siderolabs/fuse3",
			"siderolabs/glibc",
			"siderolabs/nfs-utils",
			"siderolabs/util-linux-tools",
		]
	}
}

t: Role: "longhorn": {
	// requires manual kubectl label node <name> node-role.kubernetes.io/longhorn
	patches: [{
		apiVersion: "v1alpha1"
		kind:       "SysfsConfig"
		params: "kernel.mm.hugepages.hugepages-2048kB.nr_hugepages": "1024"
	}, {
		apiVersion: "v1alpha1"
		kind:       "KernelModuleConfig"
		name:       "vfio_pci"
	}, {
		apiVersion: "v1alpha1"
		kind:       "KernelModuleConfig"
		name:       "uio_pci_generic"
	}]
	schematic: customization: systemExtensions: officialExtensions: [
		"siderolabs/iscsi-tools",
		"siderolabs/nfsd",
	]
}

t: Role: "intel": schematic: customization: systemExtensions: officialExtensions: ["siderolabs/intel-ucode"]

t: Role: "reset": schematic: customization: extraKernelArgs: ["talos.experimental.wipe=system"]
t: Role: "maintainance": schematic: customization: extraKernelArgs: ["talos.experimental.wipe=system:EPHEMERAL,STATE"]

t: Role: "vpn-egress": patches: [{
	// requires manual kubectl label node <name> node-role.kubernetes.io/vpn-egress
	machine: network: interfaces: [{
		deviceSelector: physical: true
		dhcp: true
		vlans: [{
			vlanId: 25
			addresses: ["10.25.0.2/28"]
			routes: [{network: "0.0.0.0/0", gateway: "10.25.0.1", metric: 2048}]
		}]
	}]
}]
