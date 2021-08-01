package kube

k: DaemonSet: "kube-vip-ds": spec: {
	selector: matchLabels: name: "kube-vip-ds"
	template: {
		metadata: labels: name: "kube-vip-ds"
		spec: {
			containers: [{
				args: ["manager"]
				env: [{
					name:  "vip_arp"
					value: "true"
				}, {
					name:  "vip_interface"
					value: "eno1"
				}, {
					name:  "port"
					value: "6443"
				}, {
					name:  "cp_enable"
					value: "true"
				}, {
					name:  "cp_namespace"
					value: "kube-system"
				}, {
					name:  "svc_enable"
					value: "true"
				}, {
					name:  "vip_leaderelection"
					value: "true"
				}, {
					name:  "vip_leaseduration"
					value: "5"
				}, {
					name:  "vip_renewdeadline"
					value: "3"
				}, {
					name:  "vip_retryperiod"
					value: "1"
				}, {
					name:  "vip_address"
					value: "192.168.1.2"
				}]
				image:           "plndr/kube-vip:v0.3.7"
				imagePullPolicy: "Always"
				name:            "kube-vip"
				resources: {}
				securityContext: {
					runAsGroup: 0
					runAsUser: 0
					capabilities: add: [
						"NET_ADMIN",
						"NET_RAW",
						"SYS_TIME"
					]
				}
			}]
			hostNetwork: true
			nodeSelector: "node-role.kubernetes.io/master": ""
			serviceAccountName: "kube-vip"
			tolerations: [{
				effect: "NoSchedule"
				key:    "node-role.kubernetes.io/master"
			}]
		}
	}
}

k: ServiceAccount: "kube-vip": {}

k: ClusterRole: "system:kube-vip-role": {
	metadata: annotations: "rbac.authorization.kubernetes.io/autoupdate": "true"
	rules: [{
		apiGroups: [""]
		resources: ["services", "services/status", "nodes"]
		verbs: ["list", "get", "watch", "update"]
	}, {
		apiGroups: ["coordination.k8s.io"]
		resources: ["leases"]
		verbs: ["list", "get", "watch", "update", "create"]
	}]
}

k: ClusterRoleBinding: "system:kube-vip-binding": {
	roleRef: {
		apiGroup: "rbac.authorization.k8s.io"
		kind:     "ClusterRole"
		name:     "system:kube-vip-role"
	}
	subjects: [{
		kind:      "ServiceAccount"
		name:      "kube-vip"
		namespace: "kube-system"
	}]
}

k: GitRepository: "kube-vip-cloud-provider": spec: {
	interval: "1h"
	ref: tag: "0.1"
	url: "https://github.com/kube-vip/kube-vip-cloud-provider"
	ignore: """
		/*
		!/manifest
		"""
}

k: Kustomization: "kube-vip-cloud-provider": spec: {
	interval: "1h"
	path:     "./manifest"
	prune:    true
	sourceRef: {
		kind: "GitRepository"
		name: "kube-vip-cloud-provider"
	}
	validation: "client"
}

k: ConfigMap: "kubevip": data: "range-global": "192.168.1.6-192.168.1.9"
