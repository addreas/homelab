package kube

k: StatefulSet: "yanzi-gateway": {
	spec: {
		template: spec: {
			containers: [{
				name:  "border-router"
				image: "ghcr.io/addreas/gw-base:latest"
				command: ["border-router-x86_64-linux-R4.6.0.native", "-s", "/dev/yanzi-serial-radio"]
				volumeMounts: [{
					name:      "border-router-bin"
					mountPath: "/usr/local/bin"
				}, {
					mountPath: "/dev/net/tun"
					name:      "dev-tun"
				}]
				securityContext: {
					capabilities: add: ["NET_ADMIN"]
					runAsGroup: 0
					runAsUser:  0
				}
				resources: limits: "addem.se/dev_yanzi_serial_radio": "1"
			}, {
				name:  "fiona"
				image: "ghcr.io/addreas/gw-fiona:4.9.9"
                command: ["java", "-DexitToReboot", "-jar", "/app/fiona.jar"]
				securityContext: capabilities: add: ["NET_BIND_SERVICE"]
				volumeMounts: [{
					name:      "var-db-yanzi"
					mountPath: "/var/db/yanzi"
				}]
			}]
			volumes: [{
				name: "border-router-bin"
				secret: {
					secretName:  "yanzi-native-border-router-bin"
					defaultMode: 0o777
				}
			}, {
				hostPath: {
					path: "/dev/net/tun"
					type: "CharDevice"
				}
				name: "dev-tun"
			}]
		}
		volumeClaimTemplates: [{
			metadata: name: "var-db-yanzi"
			spec: {
				accessModes: ["ReadWriteOnce"]
				resources: requests: storage: "5Gi"
			}
		}]
	}
}
