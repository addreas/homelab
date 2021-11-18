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
		image:           "ghcr.io/kube-vip/kube-vip:v0.3.9"
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

