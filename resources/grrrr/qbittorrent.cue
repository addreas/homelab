package kube

import "github.com/addreas/homelab/util"

k: StatefulSet: qbittorrent: {
	spec: {
		template: {
			metadata: labels: "vpn-egress": "gateway"
			spec: {
				nodeSelector: {
					"kubernetes.io/hostname": "sergio"
				}
				securityContext: {
					sysctls: [{
						name:  "net.ipv4.conf.all.src_valid_mark"
						value: "1"
					}]
				}
				initContainers: [{
					name:  "wg-quick"
					image: "nixery.dev/shell/iproute/wireguard-tools"
					command: ["sh", "-c"]
					args: ["""
						wg-quick up /config/wg0.conf
						ip route add 10.96.0.0/12 dev eth0
						ip route add 10.0.0.0/16 dev eth0
						"""]

					securityContext: {
						privileged: true // not sure which cap is required for sysctl
						capabilities: add: ["NET_ADMIN", "NET_RAW"]
					}
					volumeMounts: [{
						name:      "wg0-conf"
						mountPath: "/config"
					}]
				}, util.copyStatic & {
					volumeMounts: [{
						mountPath: "/static/config/qBittorrent/config"
						name:      "static-config"
					}, {
						mountPath: "/config/qBittorrent"
						name:      "config"
					}]
				}]
				containers: [{
					name:            "qbittorrent"
					image:           "ghcr.io/hotio/qbittorrent"
					imagePullPolicy: "Always"
					command: ["sh", "-c"]
					args: ["""
						exec /$APP_DIR/qbittorrent-nox --profile="$CONFIG_DIR" --webui-port=8080
						"""]
					ports: [{
						containerPort: 8080
					}]
					volumeMounts: [{
						mountPath: "/config/qBittorrent"
						name:      "config"
					}, {
						mountPath: "/videos"
						name:      "sergio-videos"
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
				}, {
					name:  "exporter"
					image: "esanchezm/prometheus-qbittorrent-exporter:v1.1.0"
					resources: limits: {
						cpu:    "150m"
						memory: "64Mi"
					}
					ports: [{
						containerPort: 8000
					}]
					env: [{
						name:  "QBITTORRENT_HOST"
						value: "localhost"
					}, {
						name:  "QBITTORRENT_PORT"
						value: "8080"
					}]
				}, {
					name:  "socks-proxy"
					image: "xkuma/socks5"
					resources: limits: {
						memory: "64Mi"
						cpu:    "10m"
					}
					ports: [{
						containerPort: 1080
					}]
				}]
				volumes: [{
					name: "wg0-conf"
					secret: {
						secretName:  "wg0-conf"
						defaultMode: 0o600
					}
				}, {
					name: "static-config"
					configMap: name: "qbittorrent-static-config"
				}, {
					name: "sergio-videos"
					persistentVolumeClaim: claimName: "sergio-videos"
				}, {
					name: "config"
					persistentVolumeClaim: claimName: "sergio-qbittorrent-config"
				}]
			}
		}
	}
}

k: PersistentVolumeClaim: "sergio-qbittorrent-config": spec: resources: requests: storage: "5Gi"
k: PersistentVolume: "sergio-qbittorrent-config": spec: local: path: "/mnt/solid-data/qbittorrent-config"

k: Service: qbittorrent: spec: ports: [{
	name: "http"
	port: 8080
}, {
	name: "metrics"
	port: 8000
}]

k: ServiceMonitor: qbittorrent: spec: endpoints: [{
	port:     "metrics"
	interval: "60s"
}]

k: Ingress: qbittorrent: _authproxy: true

k: ConfigMap: "qbittorrent-static-config": data: {
	"qBittorrent.conf": #"""
		[BitTorrent]
		Session\DefaultSavePath=/videos/downloads
		Session\Interface=wg0
		Session\InterfaceName=wg0

		[Meta]
		MigrationVersion=2

		[Preferences]
		Advanced\AnonymousMode=true
		Advanced\RecheckOnCompletion=true
		Advanced\trackerPort=9000
		Connection\GlobalDLLimitAlt=10240
		Connection\GlobalUPLimitAlt=10240
		Connection\Interface=wg0
		Connection\InterfaceName=wg0
		Connection\ResolvePeerCountries=true
		Connection\alt_speeds_on=true
		Downloads\SavePath=/videos/downloads/
		General\UseRandomPort=true
		WebUI\AlternativeUIEnabled=false
		WebUI\AuthSubnetWhitelist=10.0.0.0/8
		WebUI\AuthSubnetWhitelistEnabled=true
		WebUI\CSRFProtection=true
		WebUI\ClickjackingProtection=true
		WebUI\HostHeaderValidation=true
		WebUI\LocalHostAuth=false
		WebUI\MaxAuthenticationFailCount=5
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

k: Service: "vpn-egress": {
	_selector: "vpn-egress": "gateway"
	spec: ports: [{
		name: "socks"
		port: 1080
	}]
}

k: CiliumNetworkPolicy: "vpn-egress-gateway": {
	spec: {
		endpointSelector: matchLabels: "vpn-egress": "gateway"
		ingress: [{
			fromEntities: ["cluster"]
		}]
		egress: [{
			toEndpoints: [{
				matchLabels: {
					"k8s:io.kubernetes.pod.namespace": "kube-system"
					"k8s:k8s-app":                     "kube-dns"
				}
			}]
			toPorts: [{
				ports: [{
					port:     "53"
					protocol: "ANY"
				}]
				rules: dns: [{
					matchPattern: "*"
				}]
			}]
		}, {
			toFQDNs: [{
				matchName: "se1.wg.azirevpn.net"
			}]
			toPorts: [{
				ports: [{
					port:     "51820"
					protocol: "UDP"
				}]
			}]
		}]
	}
}

k: CiliumNetworkPolicy: "vpn-egress-clients": spec: {
	endpointSelector: matchLabels: "vpn-egress": "client"
	ingress: [{
		fromEntities: ["cluster"]
	}]
	egress: [{
		toEntities: ["cluster"]
	}, {
		toEndpoints: [{
			matchLabels: "vpn-egress": "gateway"
		}]
		toPorts: [{
			ports: [{
				port:     "1080"
				protocol: "TCP"
			}]
		}]
	}]
}

k: GrafanaDashboard: "qbittorrent": spec: {
	source: remote: url: "https://raw.githubusercontent.com/esanchezm/prometheus-qbittorrent-exporter/master/grafana/dashboard.json"
	datasources: [{
		datasourceRef: name:      "prometheus"
		datasourceRef: namespace: "monitoring"
		inputName: "DS_PROMETHEUS"
	}]
	plugins: [{
		name:    "grafana-piechart-panel"
		version: "1.6.1"
	}]
}
