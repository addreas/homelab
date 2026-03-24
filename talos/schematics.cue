package talos

import (
	"github.com/siderolabs/image-factory/pkg/schematic"
)

t: Schematics: close({[#Role | #Tag]: schematic.#Schematic})

t: Schematics: "base": customization: {
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

t: Schematics: "intel": customization: systemExtensions: officialExtensions: [
	"siderolabs/intel-ucode",
]

t: Schematics: "longhorn": customization: systemExtensions: officialExtensions: [
	"siderolabs/iscsi-tools",
	"siderolabs/nfs-utils",
	"siderolabs/nfsd",
]
