package kube

k: StatefulSet: radarr: spec: {
	template: {
		metadata: labels: "vpn-egress": "client"
		spec: {
			containers: [{
				name:            "radarr"
				image:           "lscr.io/linuxserver/radarr:6.4.4"
				command: ["/app/radarr/bin/Radarr", "-nobrowser", "-data=/config"]
				ports: [{
					containerPort: 7878
				}]
				volumeMounts: [{
					mountPath: "/config"
					name:      "config"
				}, {
					mountPath: "/videos"
					name:      "videos"
				}]
				resources: {
					limits: {
						cpu:    "1500m"
						memory: "2Gi"
					}
					requests: {
						cpu:    "100m"
						memory: "512Mi"
					}
				}
			}]
			volumes: [{
				name: "videos"
				persistentVolumeClaim: claimName: "videos"
			}]
		}
	}
	volumeClaimTemplates: [{
		metadata: name: "config"
		spec: resources: requests: storage: "5Gi"
	}]
}

k: Service: radarr: spec: {}

k: HTTPRoute: radarr: _authproxy: true
