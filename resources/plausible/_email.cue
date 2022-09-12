package kube

k: Service: "plausible-smtp": spec: ports: [{
	name: "plausible-smtp"
}]

k: Deployment: "plausible-smtp": spec: template: spec: containers: [{
	image: "bytemark/smtp:latest"
	ports: [{containerPort: 25}]
	securityContext: runAsUser: 0
	readinessProbe: {
		tcpSocket: port: 25
		initialDelaySeconds: 20
		failureThreshold:    6
		periodSeconds:       10
	}
	livenessProbe: {
		tcpSocket: port: 25
		initialDelaySeconds: 30
		failureThreshold:    3
		periodSeconds:       10
	}
}]
