package kube

k: StatefulSet: bitwarden: spec: {
	template: spec: containers: [{
		image: "vaultwarden/server:\(githubReleases["dani-garcia/vaultwarden"])"
		envFrom: [{
			configMapRef: name: "bitwarden"
		}]
		env: [{
			name: "SMTP_USERNAME"
			valueFrom: secretKeyRef: {
				name: "bitwarden-smtp"
				key:  "emailUser"
			}
		}, {
			name: "SMTP_PASSWORD"
			valueFrom: secretKeyRef: {
				name: "bitwarden-smtp"
				key:  "emailPassword"
			}
		}]
		ports: [{
			containerPort: 8080
			name:          "http"
		}, {
			containerPort: 3012
			name:          "websocket"
		}]
		volumeMounts: [{
			mountPath: "/data"
			name:      "data"
		}]
		resources: {
			limits: {
				cpu:    "100m"
				memory: "256Mi"
			}
			requests: {
				cpu:    "5m"
				memory: "128Mi"
			}
		}
	}]
	volumeClaimTemplates: [{
		metadata: name: "data"
		spec: {
			accessModes: ["ReadWriteOnce"]
			resources: requests: storage: "5Gi"
		}
	}]
}
