package kube

k: StatefulSet: qbittorrent: spec: {
	template: {
		metadata: labels: "vpn-egress": "client"
		spec: {
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
				name: "videos"
				persistentVolumeClaim: claimName: "videos"
			}, {
				name: "cache"
				emptyDir: {}
			}]
			terminationGracePeriodSeconds: 5
		}
	}
	volumeClaimTemplates: [{
		metadata: name: "config"
		spec: resources: requests: storage: "5Gi"
	}]
}

k: Service: qbittorrent: {}

k: HTTPRoute: qbittorrent: _authproxy: true
