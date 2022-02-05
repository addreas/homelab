package kube

import "strings"

let services = {
	kubelet: {
		port: 10250
		paths: ["/metrics", "/metrics/cadvisor", "/metrics/probes"]
	}
	"kube-scheduler": {
		port: 10259
		paths: ["/metrics"]
	}
	"kube-controller-manager": {
		port: 10257
		paths: ["/metrics"]
	}
}

k: DaemonSet: "control-plane-metrics-rbac-proxy": spec: template: spec: {
	hostNetwork: true
	serviceAccountName: "control-plane-metrics-rbac-proxy"
	containers: [ for n, p in services {
		name:  n
		image: "quay.io/brancz/kube-rbac-proxy:v0.11.0"
		args: [
			"--logtostderr",
			"--allow-paths=\(strings.Join(p.paths, ","))",
			"--secure-listen-address=:\(p.port)",
			"--upstream=https://127.0.0.1:\(p.port)/",
			"--upstream-ca-file=/var/run/secrets/kubernetes.io/serviceaccount/ca.crt",
		]
	}]
}

k: Service: {
	for name, p in services {
		"\(name)": {
			metadata: {
				labels: {
					"app.kubernetes.io/name": name
					"k8s-app":                name
				}
				namespace: "kube-system"
			}
			spec: {
				selector: app: "control-plane-metrics-rbac-proxy"
				ports: [{
					name: "https-metrics"
					port: p.port
				}]
			}

		}
	}
}


k: ServiceAccount: "control-plane-metrics-rbac-proxy": {}

k: ClusterRole: "control-plane-metrics-rbac-proxy": rules: [{
	apiGroups: ["authentication.k8s.io"]
	resources: ["tokenreviews"]
	verbs: ["create"]
}, {
	apiGroups: ["authorization.k8s.io"]
	resources: ["subjectaccessreviews"]
	verbs: ["create"]
}]

k: ClusterRoleBinding: "control-plane-metrics-rbac-proxy": {
	roleRef: {
		apiGroup: "rbac.authorization.k8s.io"
		kind: "ClusterRole"
		name: "control-plane-metrics-rbac-proxy"
	}
	subjects: [{
		kind: "ServiceAccount"
		name: "control-plane-metrics-rbac-proxy"
		namespace: "monitoring"
	}]
}

k: ClusterRole: "metrics-getter": rules: [{
	nonResourceURLs: ["/metrics", "/metrics/cadvisor", "/metrics/probes"]
	verbs: ["get"]
}]

k: ClusterRoleBinding: "vmagent-main-metrics-getter": {
	roleRef: {
		apiGroup: "rbac.authorization.k8s.io"
		kind: "ClusterRole"
		name: "metrics-getter"
	}
	subjects: [{
		kind: "ServiceAccount"
		name: "vmagent-main"
		namespace: "monitoring"
	}]
}
