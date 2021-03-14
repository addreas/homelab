package kube

k: Deployment: "cirrus-exporter": {
	metadata: labels: Labels
	spec: {
		replicas: 1
		selector: matchLabels: Labels
		template: {
			metadata: labels: Labels
			spec: {
				containers: [{
					name:  "fogis-calendar-exporter"
					image: "ghcr.io/jonasdahl/nextjs-fogis-calendar-exporter"
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
