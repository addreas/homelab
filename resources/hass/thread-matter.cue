package kube

k: StatefulSet: "hass-thread-matter": spec: {
	template: {
		metadata: annotations: annotations: "k8s.v1.cni.cncf.io/networks": "macvlan-conf"
		spec: {
			securityContext: sysctls: [{
				name:  "net.ipv4.conf.all.src_valid_mark"
				value: "0"
			}, {
				name:  "net.ipv4.conf.all.forwarding"
				value: "1"
			}, {
				name:  "net.ipv6.conf.all.forwarding"
				value: "1"
				// https://github.com/home-assistant-libs/python-matter-server#requirements-to-communicate-with-thread-devices-through-thread-border-routers
				// }, {
				// 	name:  "net.ipv6.conf.wlan0.accept_ra"
				// 	value: "2"
				// }, {
				// 	name:  "net.ipv6.conf.wlan0.accept_ra_rt_info_max_plen=64"
				// 	value: "1"
			}]
			initContainers: [{
				name:  "default-route"
				image: "nixery.dev/iproute2"
				command: ["ip", "route", "delete", "default", "via", "192.168.0.1"]
				securityContext: capabilities: add: ["NET_ADMIN"]
			}]
			containers: [{
				name:  "otbr"
				image: "openthread/otbr"
				ports: [{containerPort: 8080}, {containerPort: 8081}]
				resources: limits: "addem.se/dev_thread_rcp": "1"
				args: [
					"--radio-url=spinel+hdlc+uart:///dev/thread-rcp",
				]
			}, {
				name:  "matter-server"
				image: "ghcr.io/home-assistant-libs/python-matter-server:stable"
				ports: [{containerPort: 5580}]
				args: [
					"--storage-path=/data",
				]
				volumeMounts: [{
					name:      "matter-storage"
					mountPath: "/data"
				}]
			}]
		}
	}
	volumeClaimTemplates: [{
		metadata: name: "matter-storage"
		spec: {
			accessModes: ["ReadWriteOnce"]
			resources: requests: storage: "1Gi"
		}
	}]
}

k: Service: "hass-thread-matter": spec: ports: [{
	name: "http-otbr1"
	port: 8080
}, {
	name: "http-otbr2"
	port: 8081
}, {
	name: "http-matter"
	port: 8082
}]
