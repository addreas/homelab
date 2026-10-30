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

t: Role: "base": {
	patches: [{
		machine: features: diskQuotaSupport: true
	}, {
		apiVersion: "v1alpha1"
		kind:       "SysctlConfig"
		params: "user.max_user_namespaces": "65536"
	}, {
		apiVersion: "v1alpha1"
		kind:       "DHCPv4Config"
		name:       "eno1"
	}, {
		apiVersion: "v1alpha1"
		kind:       "KubeNetworkConfig"
		dnsDomain:  "cluster.local"
		podSubnets: ["10.48.0.0/16"]
		serviceSubnets: ["10.96.0.0/12"]
	}, {
		apiVersion:                          "v1alpha1"
		kind:                                "KubeletConfig"
		defaultRuntimeSeccompProfileEnabled: true
		extraArgs: "rotate-server-certificates": true
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

t: Role: "cilium": patches: [{
	apiVersion: "v1alpha1"
	kind:       "KubeFlannelCNIConfig"
	$patch:     "delete"
}, {
	apiVersion: "v1alpha1"
	kind:       "ResolverConfig"
	hostDNS: forwardKubeDNSToHost: false // cilium issue: https://github.com/siderolabs/talos/pull/9200
}]

t: Role: "nvme-install-disk": patches: [{
	apiVersion: "v1alpha1"
	kind:       "UnattendedInstallConfig"
	provisioning: {
		// diskSelector: match: #"(disk.size > 200u * GB) && (disk.size < 1000u * GB)"#
		diskSelector: match: #"disk.transport == "nvme" && disk.size < 1000u * GiB"#
		// diskSelector: match: #"disk.dev_path == "/dev/nvme1n1""#
		wipe: true
	}

}]

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

t: Role: "talos-logs": patches: [{
	machine: logging: destinations: [{
		endpoint: "tcp://127.0.0.1:60514/"
		format:   "json_lines"
		extraTags: cluster: "qb"
	}]
}, {
	apiVersion: "v1alpha1"
	kind:       "KubeStaticPodConfig"
	name:       "talos-logs"
	pod: {
		apiVersion: "v1"
		kind:       "Pod"
		metadata: {
			name:      "talos-logs"
			namespace: "kube-system"
			labels: "app.kubernetes.io/name": "talos-logs"
		}
		spec: {
			hostNetwork: true
			dnsPolicy:   "ClusterFirstWithHostNet"
			containers: [{
				name:  "sink"
				image: "alpine/socat:1.8.0.1"
				args: ["-u", "TCP-LISTEN:60514,reuseaddr,fork", "-"]
				securityContext: {
					allowPrivilegeEscalation: false
					capabilities: drop: ["ALL"]
					runAsNonRoot: true
					runAsUser:    1000
					runAsGroup:   1000
					seccompProfile: type: "RuntimeDefault"
				}
				resources: requests: {
					cpu:    "5m"
					memory: "16Mi"
				}
			}]
		}
	}
}]

// requires manual kubectl label node <name> node-role.kubernetes.io/vpn-egress
t: Role: "vpn-egress": patches: [{
	apiVersion: "v1alpha1"
	kind:       "VLANConfig"
	name:       "eno1.25"
	vlanID:     25
	parent:     "eno1"
	addresses: [{address: "10.25.0.2/28"}]
	routes: [{
		// for same node egress, main table but high metric
		gateway: "10.25.0.1"
		metric:  2048
	}, {
		// for cross node egress, completely separate table
		gateway: "10.25.0.1"
		table:   "125"
	}]
}, {
	apiVersion: "v1alpha1"
	kind:       "RoutingRuleConfig"
	name:       "1000"
	src:        "10.25.0.2/32"
	table:      "125"
	action:     "unicast"
}]

t: Role: "iot-bridge": patches: [{
	apiVersion: "v1alpha1"
	kind:       "VLANConfig"
	name:       "eno1.2"
	vlanID:     2
	parent:     "eno1"
}, {
	apiVersion: "v1alpha1"
	kind:       "BridgeConfig"
	name:       "br-iot"
	links: ["eno1.2"]
}]
