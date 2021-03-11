package kube

k: StatefulSet: jackett: {
	_selector: "app": "jackett"
	spec: {
		template: {
			metadata: labels: "vpn-egress": "client"
			spec: {
				securityContext: fsGroup: 1000
				containers: [{
					name:  "jackett"
					image: "ghcr.io/hotio/jackett"
					ports: [{
						containerPort: 9117
					}]
					env: [{
						name:  "PUID"
						value: "1000"
					}, {
						name:  "PGID"
						value: "1000"
					}, {
						name:  "UMASK"
						value: "002"
					}, {
						name:  "TZ"
						value: "Europe/Stockholm"
					}, {
						name:  "DEBUG"
						value: "yes"
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
		selector: app: "jackett"
		ports: [{
			name: "http"
			port: 9117
		}]
	}
}

k: Ingress: jackett: {
	metadata: annotations: {
		"cert-manager.io/cluster-issuer":     "addem-se-letsencrypt"
		"ingress.kubernetes.io/ssl-redirect": "true"
		// ingress.kubernetes.io/auth-tls-error-page: getcert.addem.se
		"ingress.kubernetes.io/auth-tls-secret":        "client-auth-root-ca-cert"
		"ingress.kubernetes.io/auth-tls-strict":        "true"
		"ingress.kubernetes.io/auth-tls-verify-client": "on"
	}
	spec: {
		tls: [{
			hosts: ["jackett.addem.se"]
			secretName: "jackett-cert"
		}]
		rules: [{
			host: "jackett.addem.se"
			http: paths: [{
				path:     "/"
				pathType: "Prefix"
				backend: service: {
					name: "jackett"
					port: number: 9117
				}
			}]
		}]
	}
}
