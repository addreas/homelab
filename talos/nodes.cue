@experiment(try)
package talos

import (
	"list"
	"encoding/yaml"
	S "github.com/siderolabs/image-factory/pkg/schematic"
)

#Role: "control-plane" | "worker"
#Tag:  "base" | "intel" | "longhorn"

#NodeSpec: {
	hostname: string

	mac?: string

	role: [#Role]: true
	roles: [...#Role]
	roles: [for r, _ in role {r}]

	tag: [#Tag]: true
	tags: [...#Tag]
	tags: [for t, _ in tag {t}]

	patch:     string
	schematic: S.#Schematic

	...
}

nodes: {
	let cp = {role: "control-plane": _}
	let worker = {role: "worker": _}
	let longhorn = {tag: "longhorn": _}

	[string]: tag: "intel": _

	"talos-3cf-jbr": {mac: "de:ad:be:ef", cp}
	"talos-lcn-k2p": {mac: "de:ad:be:ef", cp}
	"talos-po9-l54": {mac: "de:ad:be:ef", cp}

	"talos-hz2-2oi": {mac: "de:ad:be:ef", worker, longhorn}
	"talos-o1t-0lm": {mac: "de:ad:be:ef", worker}
}

nodes: [name=string]: #NodeSpec & {
	hostname: name

	roles: [...string]
	tags: [...string]

	patch: yaml.MarshalStream([
		_patches["base"],
		for role in roles try {
			_patches[role]?
		},
		for tag in tags try {
			_patches[tag]?
		},
	])

	// merge deep --strategy append...
	schematic: (#MergeAppend & {
		in: [
			_schematics["base"],
			for role in roles try {_schematics[role]?},
			for tag in tags try {_schematics[tag]?},
		]
		appendPaths: [["customization", "extraKernelArgs"], ["customization", "systemExtensions", "officialExtensions"]]
	}).out
}

#Omit: {
	in: {...}
	out: {...}
	skip: [...string]
	out: {for k, v in in if !list.Contains(skip, k) {(k): v}}
}

#MergeAppend: {
	in: [...{...}]
	out: {...}

	appendPaths: [...[...string]]

	out: {
		for i in in {
			(#Omit & {in: i, skip: [for p in appendPaths {p[0]}]}).out
		}
		for p in appendPaths {
			(p[0]): {
				if len(p) == 1 {
					list.Concat([for i in in if i[p[0]] != _|_ {i[p[0]]}])
				}
				if len(p) > 1 {
					_ok: _
					for i in in {
						(#Omit & {in: i[p[0]], skip: [for p in appendPaths if len(p) > 1 {p[1]}]}).out
					}
					(p[1]): {
						if len(p) == 2 {
							list.Concat([for i in in if i[p[0]][p[1]] != _|_ {i[p[0]][p[1]]}])
						}
						if len(p) > 2 {
							for i in in {
								(#Omit & {in: i[p[0]][p[1]], skip: [for p in appendPaths if len(p) > 2 {p[2]}]}).out
							}
							(p[2]): {
								if len(p) == 3 {
									list.Concat([for i in in if i[p[0]][p[1]][p[2]] != _|_ {i[p[0]][p[1]][p[2]]}])
								}
							}
						}
					}
				}
			}
		}
	}
}

// TODO: separate file
_schematics: close({[#Role | #Tag]: _})
_schematics: {
	"base": customization: {
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

	"intel": customization: systemExtensions: officialExtensions: [
		"siderolabs/intel-ucode",
	]

	"longhorn": customization: systemExtensions: officialExtensions: [
		"siderolabs/iscsi-tools",
		"siderolabs/nfs-utils",
		"siderolabs/nfsd",
	]
}

_patches: close({[#Role | #Tag]: _})
_patches: {
	"base": {
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

	"control-plane": {
		machine: {
			network: interfaces: [{
				deviceSelector: physical: true
				dhcp: true
				vip: ip: "10.24.0.24"
			}]
			features: kubernetesTalosAPIAccess: enabled: true
		}
	}

	"worker": {
		machine: nodeLabels: "node-role.kubernetes.io/worker": ""
	}

	"longhorn": {
		machine: {
			sysfs: "kernel.mm.hugepages.hugepages-2048kB.nr_hugepages": 1024
			kernel: modules: [{
				name: "vfio_pci"
			}, {
				name: "uio_pci_generic"
			}]
		}
	}
}
