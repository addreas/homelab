package kube

k: Deployment: "fogis": {
	_selector: Labels
	spec: {
		replicas: 1
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
