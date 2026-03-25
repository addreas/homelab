package talos

t: Role: "control-plane": patch: machine: {
	network: interfaces: [{
		deviceSelector: physical: true
		dhcp: true
		vip: ip: "10.24.0.24"
	}]
	features: kubernetesTalosAPIAccess: enabled: true
}

t: Role: "worker": patch: machine: nodeLabels: "node-role.kubernetes.io/worker": ""

t: Role: "base": {
	patch: cluster: {
		controlPlane: endpoint: "https://api.qb:6443"
		clusterName: "qb"
		network: {
			dnsDomain: "cluster.local"
			podSubnets: ["10.48.0.0/16"]
			serviceSubnets: ["10.96.0.0/12"]
			cni: name: "none"
		}
		proxy: disabled:    true
		discovery: enabled: false
		allowSchedulingOnControlPlanes: false
	}

	patch: machine: {
		kubelet: {
			defaultRuntimeSeccompProfileEnabled: true
			disableManifestsDirectory:           true
		}
		install: {
			disk: "/dev/nvme0n1"
			wipe: true
		}
		features: {
			diskQuotaSupport: true
			kubePrism: {
				enabled: true
				port:    7445
			}
			hostDNS: {
				enabled:              true
				forwardKubeDNSToHost: false // cilium issue: https://github.com/siderolabs/talos/pull/9200
			}
		}
	}

	schematic: customization: {
		bootloader: "sd-boot"
		extraKernelArgs: [
			"init_on_alloc=1",
			"init_on_free=1",
		]
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
	patch: machine: {
		sysfs: "kernel.mm.hugepages.hugepages-2048kB.nr_hugepages": "1024"
		kernel: modules: [{
			name: "vfio_pci"
		}, {
			name: "uio_pci_generic"
		}]
	}

	schematic: customization: systemExtensions: officialExtensions: [
		"siderolabs/iscsi-tools",
		"siderolabs/nfs-utils",
		"siderolabs/nfsd",
	]
}

t: Role: "intel": schematic: customization: systemExtensions: officialExtensions: ["siderolabs/intel-ucode"]
