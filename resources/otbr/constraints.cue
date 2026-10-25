package kube

_namespace: "otbr"

k: Namespace: (_namespace): metadata: labels: {
	"pod-security.kubernetes.io/enforce": "privileged"
	"pod-security.kubernetes.io/audit":   "privileged"
	"pod-security.kubernetes.io/warn":    "privileged"
}
