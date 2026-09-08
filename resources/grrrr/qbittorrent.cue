package kube

import utils "github.com/addreas/homelab/util"

k: StatefulSet: qbittorrent: {
	spec: {
		template: {
			metadata: labels: "vpn-egress": "client"
			spec: {
				initContainers: [utils.copyStatic & {
					volumeMounts: [{
						mountPath: "/config/qBittorrent"
						name:      "config"
					}, {
						mountPath: "/static/config/qBittorrent"
						name:      "static-config"
					}]
				}]
				containers: [{
					name:            "qbittorrent"
					image:           "lscr.io/linuxserver/qbittorrent:latest"
					imagePullPolicy: "Always"
					command: ["/app/qbittorrent-nox", "--confirm-legal-notice"]
					ports: [{
						containerPort: 8080
					}]
					volumeMounts: [{
						mountPath: "/config/qBittorrent"
						name:      "config"
					}, {
						mountPath: "/config/.cache"
						name:      "cache"
					}, {
						mountPath: "/videos"
						name:      "videos"
					}]
					resources: {
						limits: {
							memory: "2Gi"
							cpu:    "500m"
						}
						requests: {
							memory: "512Mi"
							cpu:    "250m"
						}
					}
				}]
				volumes: [{
					name: "static-config"
					configMap: name: "qbittorrent-static-config"
				}, {
					name: "videos"
					persistentVolumeClaim: claimName: "videos"
				}, {
					name: "config"
					persistentVolumeClaim: claimName: "qbittorrent-config"
				}, {
					name: "cache"
					emptyDir: {}
				}]
				terminationGracePeriodSeconds: 5
			}
		}
	}
}

k: PersistentVolumeClaim: "qbittorrent-config": spec: resources: requests: storage: "5Gi"

k: Service: qbittorrent: spec: ports: [{
	name: "http"
	port: 8080
}, {
	name: "metrics"
	port: 8000
}]

k: HTTPRoute: qbittorrent: _authproxy: true

k: ConfigMap: "qbittorrent-static-config": data: {
	"qBittorrent.conf": #"""
		[BitTorrent]
		Session\DefaultSavePath=/videos/downloads

		[Meta]
		MigrationVersion=2

		[Preferences]
		Advanced\AnonymousMode=true
		Advanced\RecheckOnCompletion=true
		Advanced\trackerPort=9000
		Connection\GlobalDLLimitAlt=10240
		Connection\GlobalUPLimitAlt=10240
		Connection\ResolvePeerCountries=true
		Connection\alt_speeds_on=true
		Downloads\SavePath=/videos/downloads/
		General\UseRandomPort=true
		WebUI\AlternativeUIEnabled=false
		WebUI\AuthSubnetWhitelist=10.48.0.0/16
		WebUI\AuthSubnetWhitelistEnabled=true
		WebUI\CSRFProtection=true
		WebUI\ClickjackingProtection=true
		WebUI\HostHeaderValidation=true
		WebUI\LocalHostAuth=false
		WebUI\MaxAuthenticationFailCount=5
		WebUI\Address=0.0.0.0
		WebUI\Port=8080
		WebUI\ReverseProxySupportEnabled=true
		WebUI\SecureCookie=true
		"""#
	"categories.json": #"""
		{
		    "radarr": {
		        "save_path": "/videos/downloads"
		    },
		    "tv-sonarr": {
		        "save_path": "/videos/downloads"
		    }
		}
		"""#
}
