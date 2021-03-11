package kube

k: StatefulSet: sonarr: {
	_selector: "app": "sonarr"
	spec: {
		template: {
			metadata: labels: "vpn-egress": "client"
			spec: {
				securityContext: fsGroup: 1000
				containers: [{
					name:            "sonarr"
					image:           "ghcr.io/hotio/sonarr:nightly"
					imagePullPolicy: "Always"
					ports: [{
						containerPort: 8989
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
					command: ["exportarr", "sonarr"]
					env: [{
						name:  "PORT"
						value: "9707"
					}, {
						name:  "URL"
						value: "http://localhost:8989"
					}, {
						name: "APIKEY"
						valueFrom: secretKeyRef: {
							name: "sonarr-apikey"
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

k: Service: sonarr: {
	_selector: "app": "sonarr"
	spec: ports: [{
		name: "http"
		port: 8989
	}, {
		name: "metrics"
		port: 9707
	}]
}

k: ServiceMonitor: sonarr: {
	_selector: "app": "sonarr"
	spec: endpoints: [{
		port:     "metrics"
		interval: "60s"
	}]
}

k: Ingress: sonarr: {
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
			hosts: ["sonarr.addem.se"]
			secretName: "sonarr-cert"
		}]
		rules: [{
			host: "sonarr.addem.se"
			http: paths: [{
				path:     "/"
				pathType: "Prefix"
				backend: service: {
					name: "sonarr"
					port: number: 8989
				}
			}]
		}]
	}
}
