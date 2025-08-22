package kube

k: StatefulSet: jackett: {
	spec: {
		template: {
			metadata: labels: "vpn-egress": "client"
			spec: {
				containers: [{
					name:            "jackett"
					image:           "lscr.io/linuxserver/jackett:latest"
					imagePullPolicy: "Always"
					command: ["/app/Jackett/jackett", "--NoUpdates"]
					env: [{
						name: "TMPDIR"
						value: "/tmp"
					}]
					ports: [{
						name:          "http"
						containerPort: 9117
					}]
					volumeMounts: [{
						mountPath: "/config"
						name:      "config"
					}]
					resources: {
						limits: {
							cpu:    "100m"
							memory: "256Mi"
						}
						requests: cpu: "10m"
					}
				}]
				volumes: [{
					name: "config"
					persistentVolumeClaim: claimName: "jackett-config"
				}]
			}
		}
	}
}

k: PersistentVolumeClaim: "jackett-config": spec: resources: requests: storage: "1Gi"

k: Service: jackett: {}

k: Ingress: jackett: _authproxy: true
