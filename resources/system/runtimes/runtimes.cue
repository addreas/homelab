package kube

// handler for siderolabs/gvisor
k: RuntimeClass: "gvisor": handler: "runsc"

// ptrace -> kvm platform, requires /dev/kvm on the node
k: RuntimeClass: "gvisor-kvm": handler: "runsc-kvm"

// Cloud Hypervisor guest runtime, handler from siderolabs/kata-containers
k: RuntimeClass: "kata": {
	handler: "kata"
	overhead: podFixed: {
		cpu:    "250m"
		memory: "130Mi"
	}
}

// QEMU guest runtime, exposes the host CPU virt flag to the guest
k: RuntimeClass: "kata-qemu": {
	handler: "kata-qemu"
	overhead: podFixed: {
		cpu:    "250m"
		memory: "160Mi"
	}
}
