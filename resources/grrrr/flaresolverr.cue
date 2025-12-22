package kube

k: Deployment: flaresolverr: {
	spec: {
		template: {
			metadata: labels: "vpn-egress": "client"
			spec: {
				containers: [{
					image:           "ghcr.io/flaresolverr/flaresolverr:latest"
					imagePullPolicy: "Always"
					ports: [{
						name:          "http"
						containerPort: 8191
					}]
					resources: {
						limits: {
							cpu:    "2"
							memory: "512Mi"
						}
						requests: cpu: "500m"
					}
				}]
			}
		}
	}
}

k: Service: flaresolverr: {}
