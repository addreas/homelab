package kube

k: Namespace: ory: {}

k: [string]: [string]: metadata: namespace: "ory"

k: Deployment: [string]: spec: template: spec: containers: [...{
	securityContext: _ | *{
		capabilities: drop: ["ALL"]
		privileged:             false
		readOnlyRootFilesystem: true
		runAsNonRoot:           true
		runAsUser:              1000
	}
}]

_probes: {
	_port: ports[0].name
	ports: [...{name: string}]
	livenessProbe: httpGet: {
		path: "/health/alive"
		port: _port
	}
	readinessProbe: httpGet: {
		path: "/health/ready"
		port: _port
	}
}
