package kube

import (
	"crypto/md5"
	"encoding/hex"
	// "encoding/json"
	"github.com/addreas/homelab/util"
)

k: StatefulSet: "unifi-controller": {
	spec: {
		template: {
			metadata: {
				labels: "config-hash": hex.Encode(md5.Sum(k.ConfigMap."config-gateway-json".data."config.gateway.json"))
				// annotations: "k8s.v1.cni.cncf.io/networks": json.Marshal([{
				// 	"name": "cilium",
				// 	"default-route": []
				// }])
				// annotations: "v1.multus-cni.io/default-network": "default/macvlan-conf"
			}
			spec: {
				initContainers: [util.copyStatic & {
					volumeMounts: [{
						name:      "config"
						mountPath: "/usr/lib/unifi"
					}, {
						name:      "config-gateway-json"
						mountPath: "/static/usr/lib/unifi/data/sites/default"
					}]
				}]
				containers: [{
					image: "jacobalberty/unifi:v7.3.76"
					name:  "controller"
					env: [{
						name: "UNIFI_STDOUT"
						value: "true"
					}]
					ports: [{
						name:          "https"
						containerPort: 8443
					}, {
						name:          "stun"
						containerPort: 3478
						protocol:      "UDP"
					}, {
						name:          "http"
						containerPort: 8080
					}, {
						name:          "https-redirect"
						containerPort: 8843
					}, {
						name:          "http-redirect"
						containerPort: 8880
					}, {
						name:          "unifi-speedtest"
						containerPort: 6789
					}, {
						name:          "ssdp"
						containerPort: 1900
						protocol:      "UDP"
					}, {
						name:          "discovery"
						containerPort: 10001
						protocol:      "UDP"
					}]

					volumeMounts: [ for dir in ["data", "logs", "run"] {
						name:      "config"
						mountPath: "/unifi/\(dir)"
						subPath:   dir
					}]
					resources: {
						limits: {
							cpu:    "500m"
							memory: "2048Mi"
						}
						requests: {
							cpu:    "100m"
							memory: "512Mi"
						}
					}
				}, {
					image: "ghcr.io/kinvolk/busybox:latest"
					name:  "mongo-logs"
					command: ["tail", "-F", "/usr/lib/unifi/logs/mongod.log"]
					volumeMounts: [{
						name:      "config"
						mountPath: "/usr/lib/unifi/logs"
						subPath:   "logs"
					}]
					resources: {
						requests: {
							cpu:    "10m"
							memory: "64Mi"
						}
					}
				}, {
					image: "jessestuart/unifi_exporter:v0.4.0"
					name:  "exporter"
					command: ["sh", "-c"]
					args: ["""
						sleep 60
						unifi_exporter -config.file=/unifi_exporter/config.yml
						"""]
					ports: [{
						name:          "metrics"
						containerPort: 9130
					}]
					volumeMounts: [{
						name:      "exporter-config"
						mountPath: "/unifi_exporter"
					}]
					resources: limits: {
						cpu:    "200m"
						memory: "128Mi"
					}
				}]
				volumes: [{
					name: "config"
					persistentVolumeClaim: claimName: "config"
				}, {
					name: "config-gateway-json"
					configMap: name: "config-gateway-json"
				}, {
					name: "exporter-config"
					secret: secretName: "unifi-exporter-credentials"
				}]
			}
		}
		volumeClaimTemplates: [{
			metadata: name: "config"
			spec: {
				accessModes: ["ReadWriteOnce"]
				resources: requests: storage: "5Gi"
			}
		}]
	}
}

k: Service: "unifi-controller": spec: type: "LoadBalancer"

k: SealedSecret: "unifi-exporter-credentials": spec: encryptedData: "config.yml": "AgBr+zS5d8ocZzObOiP26RB7JelN1YYNEkX6Y9557PC7cZdyCwNT3vCOt3QAxRxyymkSlh+WJG7834Q4n/hBIl9ISfFAPTOU0tPY9Wyx2BL1Qd50h0glR8k4z1RKA3Mo1wEduiefBD2mZfVQFYhuqvk+FeJ88DyF8/39AdG+TW7EvUzhOabjhxEClYfFgwEDuWSLFqj+9gt3OD71f9ZOrxCYWCAUMp+2ManybcNsPMWC8PXMyFRdKF44jjZ0Zgh5oW7FsY04LgcvQ2/lwAbLZXafeg3uREFMNerBr89ErMzvRhI1QSlOs+zerJmasjO0Cf20xciktPB2LKtX/RimV3S5zGha4uR0MN1nMqV9BiZUtiWBdTkDbuuHmelR6QSNt9zWUxFxqqdt44Mxj/MDm8c6t6/xFzNlfbiCoZYDbcTLJsthBeIa2ARVRRFuzaPpj3Lw1Ui9vPcQp/dWtg6IrgMEgaWxf4qhkXaXVhFB31oiv4q6MH3rbdhJsgoZpNerz5KnOZwi+LOo9XW3RJBA0xZUl7XuGd1rqJYqE2RViDBRL9Y3sAK6Phhdn9ZJifllPItkg6p3hWJ0xyC8+40+yTSed6dtR8ZFwx+ulvC2gRVUUKd6ZyPRbsYLKWElnaQFEiru+0+ogDFnpoWnnRUdrzLML1rgdqycJUKzyODQKT58AKh+7IrabmFJ9ciup3vW435DQ+E6zd0xeEn0CDsYicxuwXQQXzTJqitF/uVcS8vml/uZSplvWDOUr6/sKlQ5iiexSMANANma05l77M4wVTPcK0nqSzskt+01++5JejAjpmM1Wbd3Q/I2k1xyV2t4o5Pg1l19kQglcTpVmOZKxemM5pFLGmCxY7L87v5+fCc6Qvaosq08ikWQNuhge9SkR9+EXP96Y1j0nGXCx2Ck0UkK7K+NAh4Em5eLb4Hz66uCY76z9V62bdKOqIZllllal7brKvgVvLQ="
