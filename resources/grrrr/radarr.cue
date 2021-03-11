package kube

k: StatefulSet: radarr: {
	_selector: "app": "radarr"
	spec: {
		template: {
			metadata: labels: "vpn-egress": "client"
			spec: {
				securityContext: fsGroup: 1000
				containers: [{
					name:            "radarr"
					image:           "ghcr.io/hotio/radarr"
					imagePullPolicy: "Always"
					ports: [{
						containerPort: 7878
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
				resources: requests: storage: "5Gi"
				accessModes: ["ReadWriteOnce"]
			}
		}]
	}
}

k: Service: radarr: {
	_selector: "app": "radarr"
	spec: ports: [{
		name: "http"
		port: 7878
	}, {
		name: "metrics"
		port: 9707
	}]
}

k: ServiceMonitor: radarr: {
	_selector: "app": "radarr"
	spec: endpoints: [{
		port:     "metrics"
		interval: "60s"
	}]
}

k: Ingress: radarr: {
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
			hosts: ["radarr.addem.se"]
			secretName: "radarr-cert"
		}]
		rules: [{
			host: "radarr.addem.se"
			http: paths: [{
				path:     "/"
				pathType: "Prefix"
				backend: service: {
					name: "radarr"
					port: number: 7878
				}
			}]
		}]
	}
}
