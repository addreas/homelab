package kube

k: ConfigMap: "nut-config": data: {
	"ups.conf": """
		[apc]
		 driver = usbhid-ups
		 port = auto
		 desc = "APC Back-UPS ES 700"
		 vendorid = 051d
		"""
	"upsd.conf": """
		LISTEN 0.0.0.0 3493
		LISTEN :: 3493
		"""
	"upsd.users": """
		[admin]
		  password = admin
		  actions = SET 
		  instcmds = ALL
		[monitor]
		  password = monitor
		  upsmon master
		"""
}

k: Deployment: "nut": spec: {
	strategy: type: "Recreate"
	template: spec: {
		containers: [{
			name:  "upsd"
			image: "gpdm/nut-upsd:latest"
			command: ["sh", "-c", """
				/usr/sbin/upsdrvctl start
				/usr/sbin/upsd -D
				"""]
			ports: [{
				name:          "nut"
				containerPort: 3493
			}]
			resources: limits: "addem.se/back_ups_es_700": 1
			volumeMounts: [{
				name:      "config"
				mountPath: "/etc/nut"
			}, {
				name:      "state"
				mountPath: "/var/run/nut"
			}]
		}]
		volumes: [{
			name: "config"
			configMap: {
				name:        "nut-config"
				defaultMode: 0o400
			}
		}, {
			name: "state"
			emptyDir: {}
		}]
	}
}

k: Service: "nut": {}
