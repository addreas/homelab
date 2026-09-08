package kube

k: Sandbox: "pi-code-agent": spec: {
	podTemplate: spec: {
		automountServiceAccountToken: false
		// hostUsers:                    false
		imagePullSecrets: [{name: "pi-sandbox-registry-auth"}]
		containers: [{
			name:            "pi"
			image:           "ghcr.io/addreas/pi-sandbox:latest"
			imagePullPolicy: "Always"
			securityContext: {
				allowPrivilegeEscalation: true
				capabilities: drop: []
			}
			env: [{
				name:  "TERM"
				value: "xterm-256color"
			}]
			volumeMounts: [{
				name:      "workspace"
				mountPath: "/workspace"
			}, {
				name:      "agent-state"
				mountPath: "/home/pi/.pi/agent"
			}]
		}]
	}
	volumeClaimTemplates: [{
		metadata: name: "workspace"
		spec: resources: requests: storage: "5Gi"
	}, {
		metadata: name: "agent-state"
		spec: resources: requests: storage: "1Gi"
	}]
}
