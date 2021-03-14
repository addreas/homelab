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
						name:  "APP_KEY"
						value: "ABCDEF1234567890ABCDEF1234567890"
					}]
					ports: [{containerPort: 3000}]
				}]
			}
		}
	}
}
