package kube

k: StatefulSet: sonarr: {
	spec: {
		template: {
			metadata: labels: "vpn-egress": "client"
			spec: {
				containers: [{
					name:            "sonarr"
					image:           "lscr.io/linuxserver/sonarr:latest"
					imagePullPolicy: "Always"
					command: ["/app/sonarr/bin/Sonarr", "-nobrowser", "-data=/config"]
					ports: [{
						name:          "http"
						containerPort: 8989
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
				}, {
					name: "config"
					persistentVolumeClaim: claimName: "sonarr-config"
				}]
			}
		}
	}
}

k: PersistentVolumeClaim: "sonarr-config": spec: resources: requests: storage: "1Gi"

k: Service: sonarr: {}

k: HTTPRoute: sonarr: _authproxy: true
