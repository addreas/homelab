package kube

k: StatefulSet: jackett: {
	spec: {
		template: {
			metadata: labels: "vpn-egress": "client"
			spec: {
				containers: [{
					name:            "jackett"
					image:           "ghcr.io/hotio/jackett"
					imagePullPolicy: "Always"
					command: ["sh", "-c"]
					args: ["""
						exec $APP_DIR/jackett --NoRestart --ListenPublic --NoUpdates --DataFolder="$CONFIG_DIR"
						"""]
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
			}
		}
		volumeClaimTemplates: [{
			metadata: name: "config"
			spec: {
				resources: requests: storage: "1Gi"
				accessModes: ["ReadWriteOnce"]
			}
		}]
	}
}

k: Service: jackett: {}

k: Ingress: jackett: _authproxy: true
