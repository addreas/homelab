package kube

_namespace: "grrrr"

k: Namespace: (_namespace): metadata: labels: {
	"pod-security.kubernetes.io/enforce": "privileged"
	"pod-security.kubernetes.io/audit":   "privileged"
	"pod-security.kubernetes.io/warn":    "privileged"
}

k: ["StatefulSet" | "Deployment"]: [string]: spec: template: metadata: labels: "vpn-egress": *"client" | "self"

k: CueExport: "homelab-grrrr": spec: {
	paths: ["./resources/grrrr"]
	prune:   true
	suspend: false
}
