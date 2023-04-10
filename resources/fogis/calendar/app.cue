package kube

k: Ingress: fogis: {}

k: Service: fogis: spec: ports: [{
	name: "http"
}]

k: Deployment: "fogis": {
	spec: {
		template: {
			spec: {
				containers: [{
					name:  "fogis-calendar-exporter"
					image: "ghcr.io/jonasdahl/nextjs-fogis-calendar-exporter:latest"
					env: [{
						name: "APP_KEY"
						valueFrom: secretKeyRef: {
							name: "fogis-app-key"
							key:  "APP_KEY"
						}
					}, {
						name: "MAPS_API_KEY"
						valueFrom: secretKeyRef: {
							name: "fogis-google-maps-key"
							key:  "MAPS_API_KEY"
						}
					}, {
						name:  "VERSION"
						value: "2"
					}]
					ports: [{containerPort: 3000}]
				}]
			}
		}
	}
}
