package kube

k: StatefulSet: bazarr: {
	_selector: "app": "bazarr"
	spec: {
		template: {
			metadata: labels: "vpn-egress": "client"
			spec: {
				securityContext: fsGroup: 1000
				containers: [{
					name:  "bazarr"
					image: "ghcr.io/hotio/bazarr"
					ports: [{
						containerPort: 6767
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
							cpu:    "100m"
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
	_selector: "app": "bazarr"
	spec: ports: [{
		name: "http"
		port: 6767
	}]
}

k: Ingress: bazarr: {
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
			hosts: ["bazarr.addem.se"]
			secretName: "bazarr-cert"
		}]
		rules: [{
			host: "bazarr.addem.se"
			http: paths: [{
				path:     "/"
				pathType: "Prefix"
				backend: service: {
					name: "bazarr"
					port: number: 6767
				}
			}]
		}]
	}
}
