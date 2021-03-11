package kube

k: StatefulSet: "unifi-controller": {
	_selector: "app": "unifi-controller"
	spec: {
		template: {
			metadata: annotations: "k8s.v1.cni.cncf.io/networks": "macvlan-conf"
			spec: {
				securityContext: fsGroup: 1000
				initContainers: [{
					name:  "copy-static"
					image: "quay.io/quay/busybox"
					command: [
						"cp",
						"-r",
						"--no-target-directory",
						"/static",
						"/",
					]
					volumeMounts: [{
						name:      "config"
						mountPath: "/config"
					}, {
						name:      "config-data-sites-default"
						mountPath: "/static/config/data/sites/default"
					}]
				}]
				containers: [{
					image: "ghcr.io/linuxserver/unifi-controller:version-6.0.45"
					name:  "unifi-controller"
					env: [{
						name:  "MEM_LIMIT"
						value: "1024M"
					}, {
						name:  "PGID"
						value: "1000"
					}, {
						name:  "PUID"
						value: "1000"
					}]
					ports: [{
						containerPort: 8443
					}]
					volumeMounts: [{
						mountPath: "/config"
						name:      "config"
					}]
					resources: {
						limits: {
							cpu:    "500m"
							memory: "1Gi"
						}
						requests: {
							cpu:    "100m"
							memory: "512Mi"
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
						containerPort: 9130
					}]
					volumeMounts: [{
						name:      "exporter-config"
						mountPath: "/unifi_exporter"
					}]
					securityContext: {
						runAsUser:  1000
						runAsGroup: 1000
					}
					resources: limits: {
						cpu:    "100m"
						memory: "128Mi"
					}
				}]
				volumes: [{
					name: "config"
					persistentVolumeClaim: claimName: "config"
				}, {
					name: "config-data-sites-default"
					configMap: name: "config-data-sites-default"
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

k: SealedSecret: "unifi-exporter-credentials": spec: encryptedData: "config.yml": "AgBr+zS5d8ocZzObOiP26RB7JelN1YYNEkX6Y9557PC7cZdyCwNT3vCOt3QAxRxyymkSlh+WJG7834Q4n/hBIl9ISfFAPTOU0tPY9Wyx2BL1Qd50h0glR8k4z1RKA3Mo1wEduiefBD2mZfVQFYhuqvk+FeJ88DyF8/39AdG+TW7EvUzhOabjhxEClYfFgwEDuWSLFqj+9gt3OD71f9ZOrxCYWCAUMp+2ManybcNsPMWC8PXMyFRdKF44jjZ0Zgh5oW7FsY04LgcvQ2/lwAbLZXafeg3uREFMNerBr89ErMzvRhI1QSlOs+zerJmasjO0Cf20xciktPB2LKtX/RimV3S5zGha4uR0MN1nMqV9BiZUtiWBdTkDbuuHmelR6QSNt9zWUxFxqqdt44Mxj/MDm8c6t6/xFzNlfbiCoZYDbcTLJsthBeIa2ARVRRFuzaPpj3Lw1Ui9vPcQp/dWtg6IrgMEgaWxf4qhkXaXVhFB31oiv4q6MH3rbdhJsgoZpNerz5KnOZwi+LOo9XW3RJBA0xZUl7XuGd1rqJYqE2RViDBRL9Y3sAK6Phhdn9ZJifllPItkg6p3hWJ0xyC8+40+yTSed6dtR8ZFwx+ulvC2gRVUUKd6ZyPRbsYLKWElnaQFEiru+0+ogDFnpoWnnRUdrzLML1rgdqycJUKzyODQKT58AKh+7IrabmFJ9ciup3vW435DQ+E6zd0xeEn0CDsYicxuwXQQXzTJqitF/uVcS8vml/uZSplvWDOUr6/sKlQ5iiexSMANANma05l77M4wVTPcK0nqSzskt+01++5JejAjpmM1Wbd3Q/I2k1xyV2t4o5Pg1l19kQglcTpVmOZKxemM5pFLGmCxY7L87v5+fCc6Qvaosq08ikWQNuhge9SkR9+EXP96Y1j0nGXCx2Ck0UkK7K+NAh4Em5eLb4Hz66uCY76z9V62bdKOqIZllllal7brKvgVvLQ="
