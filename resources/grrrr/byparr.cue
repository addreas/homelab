package kube

k: Deployment: flaresolverr: spec: template: {
	metadata: labels: "vpn-egress": "client"
	spec: containers: [{
		image: "ghcr.io/thephaseless/byparr@sha256:874f719518f617d03a60e03411fc5d090647e1a877041e81f8dc965927c7deb6"
		ports: [{
			name:          "http"
			containerPort: 8191
		}]
		resources: {
			limits: {
				cpu:    "2"
				memory: "2Gi"
			}
			requests: cpu: "500m"
		}
	}]
}

k: Service: flaresolverr: {}
