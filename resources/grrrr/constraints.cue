package kube

_namespace: "grrrr"

k: ["StatefulSet" | "Deployment"]: [string]: spec: template: metadata: labels: "vpn-egress": "client"

k: CueExport: "homelab-grrrr": spec: {
	paths: ["./resources/grrrr"]
	prune:   true
	suspend: false
}
