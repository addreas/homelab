package kube

k: StatefulSet: radarr: {
	spec: {
		template: {
			metadata: labels: "vpn-egress": "client"
			spec: {
				containers: [{
					name:            "radarr"
					image:           "ghcr.io/hotio/radarr"
					imagePullPolicy: "Always"
					command: ["sh", "-c"]
					args: ["""
						$APP_DIR/bin/Radarr --nobrowser --data="$CONFIG_DIR"
						"""]
					ports: [{
						containerPort: 7878
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
							cpu:    "1500m"
							memory: "2Gi"
						}
						requests: {
							cpu:    "100m"
							memory: "512Mi"
						}
					}
				}, {
					name:            "exportarr"
					image:           "onedr0p/exportarr:master"
					imagePullPolicy: "IfNotPresent"
					command: ["exportarr", "radarr"]
					env: [{
						name:  "PORT"
						value: "9707"
					}, {
						name:  "URL"
						value: "http://localhost:7878"
					}, {
						name: "APIKEY"
						valueFrom: secretKeyRef: {
							name: "radarr-apikey"
							key:  "apikey"
						}
					}]
					ports: [{
						containerPort: 9707
					}]
					resources: limits: {
						cpu:    "10m"
						memory: "64Mi"
					}
					volumeMounts: [{
						name:      "home-nonroot"
						mountPath: "/home/nonroot"
					}]
				}]
				volumes: [{
					name: "nfs-videos"
					nfs: {
						path:   "/export/videos"
						server: "sergio.localdomain"
					}
				}, {
					name: "home-nonroot"
					emptyDir: {}
				}]
			}
		}
		volumeClaimTemplates: [{
			metadata: name: "config"
			spec: {
				resources: requests: storage: "5Gi"
				accessModes: ["ReadWriteOnce"]
			}
		}]
	}
}

k: Service: radarr: {
	spec: ports: [{
		name: "http"
		port: 7878
	}, {
		name: "metrics"
		port: 9707
	}]
}

k: ServiceMonitor: radarr: {
	spec: endpoints: [{
		port:     "metrics"
		interval: "60s"
	}]
}

k: Ingress: radarr: {
	metadata: annotations: {
		"ingress.kubernetes.io/ssl-redirect": "true"
		// ingress.kubernetes.io/auth-tls-error-page: getcert.addem.se
		"ingress.kubernetes.io/auth-tls-secret":        "client-auth-root-ca-cert"
		"ingress.kubernetes.io/auth-tls-strict":        "true"
		"ingress.kubernetes.io/auth-tls-verify-client": "on"
	}
}
