package kube

import "encoding/json"

k: NetworkAttachmentDefinition: "macvlan-thread": spec: config: json.Marshal({
	cniVersion: "0.3.0"
	plugins: [{
		type:   "macvlan"
		master: "eno1"
		mode:   "bridge"
		ipam: {
			type: "dhcp"
			provide: [{
				option:  "host-name"
				fromArg: "K8S_POD_NAME"
			}]
		}
	}, {
		type: "sbr"
	}, {
		type: "tuning"
		capabilities: mac: true
		sysctl: {
			"net.ipv6.conf.net1.accept_ra":                  "2"
			"net.ipv6.conf.net1.accept_ra_rt_info_max_plen": "64"
		}
	}]
})

k: StatefulSet: "hass-matter": spec: {
	template: {
		metadata: annotations: "k8s.v1.cni.cncf.io/networks": json.Marshal([{
			name: "macvlan-thread"
			mac:  "02:00:00:00:00:05"
		}])
		spec: containers: [{
			name:  "matter-server"
			image: "ghcr.io/matter-js/python-matter-server:stable"
			args: [
				"--storage-path=/data",
				"--paa-root-cert-dir=/data/paa-certificates",
				"--primary-interface=net1",
			]
			ports: [{containerPort: 5580}]
			volumeMounts: [{
				name:      "data"
				mountPath: "/data"
			}]
			resources: limits: {
				cpu:    "500m"
				memory: "512Mi"
			}
		}]
	}
	volumeClaimTemplates: [{
		metadata: name: "data"
		spec: resources: requests: storage: "1Gi"
	}]
}

k: Service: "hass-matter": {}
