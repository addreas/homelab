package kube

let nodes = {
	"talos-hz2-2oi": "disk-1": path: "/dev/nvme0n1"
	"talos-o1t-0lm": "disk-1": path: "/dev/sda"
	"talos-zze-vjy": "disk-1": path: "/dev/sda"
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
