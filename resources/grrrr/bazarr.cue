package kube

k: StatefulSet: bazarr: {
	spec: {
		template: {
			metadata: labels: "vpn-egress": "client"
			spec: {
				containers: [{
					name:  "bazarr"
					image: "ghcr.io/hotio/bazarr"
					command: ["sh", "-c"]
					args: ["""
						python3 $APP_DIR/bin/bazarr.py --no-update --config $CONFIG_DIR
						"""]
					ports: [{
						containerPort: 6767
					}]
					volumeMounts: [{
						mountPath: "/config"
						name:      "config"
					}, {
						mountPath: "/videos"
						name:      "nfs-videos"
					}]
					resources: {
						limits: {
							cpu:    "150m"
							memory: "256Mi"
						}
						requests: cpu: "10m"
					}
				}]
				volumes: [{
					name: "nfs-videos"
					nfs: {
						path:   "/export/videos"
						server: "sergio.localdomain"
					}
				}]
			}
		}
		volumeClaimTemplates: [{
			metadata: name: "config"
			spec: {
				resources: requests: storage: "1Gi"
				accessModes: ["ReadWriteOnce"]
			}
		}]
	}
}

k: Service: bazarr: {
	_selector: app: "bazarr"
	spec: ports: [{
		name: "http"
		port: 6767
	}]
}

k: Ingress: bazarr: {
	metadata: annotations: {
		"ingress.kubernetes.io/ssl-redirect": "true"
		// ingress.kubernetes.io/auth-tls-error-page: getcert.addem.se
		"ingress.kubernetes.io/auth-tls-secret":        "client-auth-root-ca-cert"
		"ingress.kubernetes.io/auth-tls-strict":        "true"
		"ingress.kubernetes.io/auth-tls-verify-client": "on"
	}
}
