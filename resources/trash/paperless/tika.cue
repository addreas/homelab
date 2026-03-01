package kube

k: Deployment: "tika": spec: template: spec: {
	containers: [{
		image: "docker.io/apache/tika:latest"
		ports: [{
			name:          "http"
			containerPort: 9998
		}]
	}]
}
k: Service: "tika": spec: {}

k: Deployment: "gotenberg": spec: template: spec: {
	containers: [{
		image: "docker.io/gotenberg/gotenberg:8.25"
		command: [
			"gotenberg",
			"--chromium-disable-javascript=true",
			"--chromium-allow-list=file:///tmp/.*",
		]
		ports: [{
			name:          "http"
			containerPort: 3000
		}]
	}]
}
k: Service: "gotenberg": spec: {}
