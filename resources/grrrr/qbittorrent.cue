package kube

k: StatefulSet: qbittorrent: spec: {
	template: {
		metadata: labels: "vpn-egress": "self"
		spec: {
			securityContext: {
				sysctls: [{
					name:  "net.ipv4.conf.all.src_valid_mark"
					value: "1"
				}]
			}
			dnsPolicy: "None"
			dnsConfig: nameservers: ["10.0.0.1"]
			initContainers: [{
				name:    "wg-quick"
				image:   "nixery.dev/shell/iproute2/wireguard-tools/iptables/curl/gnused"
				command: ["wg-quick", "up", "/wg/wg0.conf"]
				securityContext: {
					privileged:   true
					runAsUser:    0
					runAsNonRoot: false
				}
				volumeMounts: [{
					name:      "wg0-conf"
					mountPath: "/wg"
					readOnly:  true
				}, {
					name:      "config"
					mountPath: "/config/qBittorrent"
				}]
			}]
			containers: [{
				name:  "qbittorrent"
				image: "lscr.io/linuxserver/qbittorrent:5.2.3"
				command: ["/app/qbittorrent-nox", "--confirm-legal-notice"]
				ports: [{
					containerPort: 8080
				}]
				volumeMounts: [{
					mountPath: "/config/qBittorrent"
					name:      "config"
				}, {
					mountPath: "/config/.cache"
					name:      "cache"
				}, {
					mountPath: "/videos"
					name:      "videos"
				}]
				resources: {
					limits: {
						memory: "2Gi"
						cpu:    "500m"
					}
					requests: {
						memory: "512Mi"
						cpu:    "250m"
					}
				}
			}]
			volumes: [{
				name: "wg0-conf"
				secret: {
					secretName: "qbittorrent-vpn"
					items: [{
						key:  "wg0.conf"
						path: "wg0.conf"
					}]
					defaultMode: 0o600
				}
			}, {
				name: "videos"
				persistentVolumeClaim: claimName: "videos"
			}, {
				name: "cache"
				emptyDir: {}
			}]
			terminationGracePeriodSeconds: 30
		}
	}
	volumeClaimTemplates: [{
		metadata: name: "config"
		spec: resources: requests: storage: "5Gi"
	}]
}

k: Service: qbittorrent: {}

k: HTTPRoute: qbittorrent: _authproxy: true
