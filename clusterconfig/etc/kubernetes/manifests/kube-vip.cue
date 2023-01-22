 let config = {
	cp_enable: "true"
	// svc_enable: "true"

	vip_arp:    "true"
	// vip_arp:    "true"
	// bgp_enable: "enable"
	address:    "192.168.1.2"
	lb_enable:  "true"
	lb_port:    "6443"

	// bgp_routerinterface: "eno1"
	// bgp_as:              "64512"
	// bgp_peeras:          "64512"
	// bgp_peeraddress:     "192.168.1.1"

	vip_interface: "eno1"
	vip_leaderelection: "true"
	cp_namespace: "kube-system"
}

apiVersion: "v1"
kind:       "Pod"
metadata: {
	creationTimestamp: null
	labels: {
		component: "kube-vip"
		tier:      "control-plane"
	}
	name:      "kube-vip"
	namespace: "kube-system"
}

spec: {
	containers: [{
		name:            "kube-vip"
		image:           "ghcr.io/kube-vip/kube-vip:v0.4.3"
		imagePullPolicy: "IfNotPresent"
		args: ["manager"]
		env: [ for k, v in config {
			name:  k
			value: v
		}]
		securityContext: capabilities: add: [
			"NET_ADMIN",
			"NET_RAW",
			"SYS_TIME",
		]
		volumeMounts: [{
			mountPath: "/etc/kubernetes/admin.conf"
			name:      "kubeconfig"
		}]
	}]
	hostAliases: [{
		hostnames: ["kubernetes"]
		ip: "127.0.0.1"
	}]
	hostNetwork:       true
	priorityClassName: "system-node-critical"
	securityContext: seccompProfile: type: "RuntimeDefault"
	volumes: [{
		hostPath: path: "/etc/kubernetes/admin.conf"
		name: "kubeconfig"
	}]
}

status: {}
