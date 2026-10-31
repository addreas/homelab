package kube

// handler for siderolabs/gvisor
k: RuntimeClass: "gvisor": handler: "runsc"
scheduling: nodeSelector: "sandbox-runtimes": "true"

// ptrace -> kvm platform, requires /dev/kvm on the node
k: RuntimeClass: "gvisor-kvm": handler: "runsc-kvm"
scheduling: nodeSelector: "sandbox-runtimes": "true"

// Cloud Hypervisor guest runtime, handler from siderolabs/kata-containers
k: RuntimeClass: "kata": {
	handler: "kata"
	scheduling: nodeSelector: "sandbox-runtimes": "true"
	overhead: podFixed: {
		cpu:    "250m"
		memory: "130Mi"
	}
}

// QEMU guest runtime, exposes the host CPU virt flag to the guest
k: RuntimeClass: "kata-qemu": {
	handler: "kata-qemu"
	scheduling: nodeSelector: "sandbox-runtimes": "true"
	overhead: podFixed: {
		cpu:    "250m"
		memory: "160Mi"
	}
}
