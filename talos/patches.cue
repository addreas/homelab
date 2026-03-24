package talos

import "github.com/siderolabs/talos/pkg/machinery/config/types/v1alpha1"

t: Patch: close({[#Role | #Tag]: v1alpha1.#Config})

t: Patch: "base": {
	cluster: {
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
	machine: {
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

}

t: Patch: "control-plane": {
	machine: {
		network: interfaces: [{
			deviceSelector: physical: true
			dhcp: true
			vip: ip: "10.24.0.24"
		}]
		features: kubernetesTalosAPIAccess: enabled: true
	}
}

t: Patch: "worker": {
	machine: nodeLabels: "node-role.kubernetes.io/worker": ""
}

t: Patch: "longhorn": {
	machine: {
		sysfs: "kernel.mm.hugepages.hugepages-2048kB.nr_hugepages": "1024"
		kernel: modules: [{
			name: "vfio_pci"
		}, {
			name: "uio_pci_generic"
		}]
	}
}
