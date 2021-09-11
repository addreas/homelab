package kube

k: DaemonSet: "kube-vip-ds": spec: {
	selector: matchLabels: name: "kube-vip-ds"
	template: {
		metadata: labels: name: "kube-vip-ds"
		spec: {
			containers: [{
				args: ["manager"]
				let config = {
					vip_arp:             "false"
					vip_interface:       "lo"
					vip_address:         "192.168.1.2"
					port:                "6443"
					cp_enable:           "true"
					cp_namespace:        "kube-system"
					svc_enable:          "true"
					vip_leaderelection:  "true"
					vip_leaseduration:   "5"
					vip_renewdeadline:   "3"
					vip_retryperiod:     "1"
					bgp_enable:          "true"
					bgp_routerinterface: "eno1"
					bgp_as:              "64512"
					bgp_peeras:          "64512"
					bgp_peeraddress:     "192.168.1.1"
					bgp_peers:           "192.168.1.11:64512::false,192.168.1.12:64512::false,192.168.1.13:64512::false"
				}

				env: [ for k, v in config {
					name:  k
					value: v
				}]
				image:           "ghcr.io/kube-vip/kube-vip:v0.3.8"
				imagePullPolicy: "Always"
				name:            "kube-vip"
				resources: {}
				securityContext: {
					runAsGroup: 0
					runAsUser:  0
					capabilities: add: [
						"NET_ADMIN",
						"NET_RAW",
						"SYS_TIME",
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

