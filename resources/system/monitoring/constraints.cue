package kube

_namespace: "monitoring"

k: ["VMAlert" | "VMAgent" | "VMAlertmanager" | "VMSingle" | "VLAgent" | "VLSingle"]: [string]: spec: resources: {
	requests: {cpu: "100m", memory: "128Mi"}
	limits: {cpu: "2", memory: "2Gi"}
}

k: Namespace: (_namespace): metadata: labels: {
	"pod-security.kubernetes.io/enforce": "privileged"
	"pod-security.kubernetes.io/audit":   "privileged"
	"pod-security.kubernetes.io/warn":    "privileged"
}
