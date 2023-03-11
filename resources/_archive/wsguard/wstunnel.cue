package kube

k: Deployment: "wstunnel": spec: template: metadata: annotations: "container.apparmor.security.beta.kubernetes.io/wstunnel": "unconfined"
k: Deployment: "wstunnel": spec: template: spec: {
	containers: [{
		image: "nixery.dev/wstunnel"
		// image: "nixery.addem.se/wstunnel"
		command: ["wstunnel", "--verbose", "--server", "ws://0.0.0.0:8080", "--restrictTo", "wireguard-server:51280"]
		ports: [{containerPort: 8080}]
	}]
}

k: Service: "wstunnel": {}

k: Ingress: "wstunnel": {}
