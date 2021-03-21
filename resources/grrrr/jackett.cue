package kube

k: StatefulSet: jackett: {
	spec: {
		template: {
			metadata: labels: "vpn-egress": "client"
			spec: {
				containers: [{
					name:  "jackett"
					image: "ghcr.io/hotio/jackett"
					command: ["sh", "-c"]
					args: ["""
						$APP_DIR/jackett --NoRestart --ListenPublic --NoUpdates --DataFolder="$CONFIG_DIR"
						"""]
					ports: [{
						containerPort: 9117
					}]
					volumeMounts: [{
						mountPath: "/config"
						name:      "config"
					}]
					resources: {
						limits: {
							cpu:    "100m"
							memory: "256Mi"
						}
						requests: cpu: "10m"
					}
				}]
			}
		}
		volumeClaimTemplates: [{
			metadata: name: "config"
			spec: {
				resources: requests: storage: "1Gi"
				accessModes: [
					"ReadWriteOnce",
				]
			}
		}]
	}
}

k: Service: jackett: {
	spec: {
		ports: [{
			name: "http"
			port: 9117
		}]
	}
}

k: Ingress: jackett: {
	metadata: annotations: {
		"ingress.kubernetes.io/ssl-redirect": "true"
		// ingress.kubernetes.io/auth-tls-error-page: getcert.addem.se
		"ingress.kubernetes.io/auth-tls-secret":        "client-auth-root-ca-cert"
		"ingress.kubernetes.io/auth-tls-strict":        "true"
		"ingress.kubernetes.io/auth-tls-verify-client": "on"
	}
}
