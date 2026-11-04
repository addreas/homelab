package kube

k: Deployment: bitwarden: spec: {
	strategy: {
		type: "RollingUpdate"
		rollingUpdate: {
			maxSurge:       1
			maxUnavailable: 0
		}
	}
	template: spec: {
		containers: [{
			image: "vaultwarden/server:1.37.4"
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
			}, {
				name:  "RSA_KEY_FILENAME"
				value: "/rsa/rsa_key"
			}, {
				name: "DATABASE_URL"
				valueFrom: secretKeyRef: {
					name: "vaultwarden-db-app"
					key:  "uri"
				}
			}]
			ports: [{
				containerPort: 8080
				name:          "http"
			}]
			volumeMounts: [{
				mountPath: "/data"
				name:      "data"
			}, {
				mountPath: "/rsa"
				name:      "rsa"
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
		volumes: [{
			name: "data"
			persistentVolumeClaim: claimName: "bitwarden-data"
		}, {
			name: "rsa"
			secret: {
				secretName: "bitwarden-rsa-key"
				items: [{
					key:  "rsa_key.pem"
					path: "rsa_key.pem"
				}]
			}
		}]
	}
}

k: PersistentVolumeClaim: "bitwarden-data": spec: {
	accessModes: ["ReadWriteMany"]
	resources: requests: storage: "5Gi"
}
