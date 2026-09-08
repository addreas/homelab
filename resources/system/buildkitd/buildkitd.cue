package kube

_namespace: "buildkitd-system"

k: Namespace: (_namespace): metadata: labels: "pod-security.kubernetes.io/enforce": "privileged"

k: Deployment: buildkitd: spec: template: spec: {
	// hostUsers: false
	containers: [{
		image: _images.buildkit
		args: [
			"--addr",
			"unix:///run/buildkit/buildkitd.sock",
			"--addr",
			"tcp://0.0.0.0:1234",
		]
		readinessProbe: {
			exec: command: ["buildctl", "debug", "workers"]
			initialDelaySeconds: 5
			periodSeconds:       30
		}
		livenessProbe: readinessProbe
		securityContext: {
			privileged:               true
			runAsNonRoot:             false
			runAsUser:                0
			runAsGroup:               0
			allowPrivilegeEscalation: true
			capabilities: drop: []
		}
		ports: [{
			containerPort: 1234
		}]
	}]
}

k: Service: buildkitd: {}
