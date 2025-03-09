package kube

k: Deployment: chrome: spec: {
	selector: {}
	template: spec: containers: [{
		image: "gcr.io/zenika-hub/alpine-chrome:123"
		command: [
			"chromium-browser",
			"--headless",
			"--no-sandbox",
			"--disable-gpu",
			"--disable-dev-shm-usage",
			"--remote-debugging-address=0.0.0.0",
			"--remote-debugging-port=9222",
			"--hide-scrollbars",
		]
		ports: [{
			name:          "debug"
			containerPort: 9222
		}]
	}]
}
k: Service: chrome: spec: {}
