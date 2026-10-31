@if(insanity)
package kube

let nodes = {
	"qbw0": "disk-1": path: "/dev/disk/by-id/nvme-KINGSTON_SNV2S2000G_50026B7382B0FFAF"
	"qbw1": "disk-1": path: "/dev/disk/by-id/ata-SAMSUNG_MZ7KH960HAJR-00005_S47NNA0N209981"
}

for nodeName, disks in nodes
for diskName, disk in disks {
	k: LonghornNode: (nodeName): spec: disks: (diskName): disk & {
		allowScheduling: _ | *true
		diskType:        _ | *"block"
		tags: _ | *[]
		diskDriver: _ | *"auto"
	}

}
