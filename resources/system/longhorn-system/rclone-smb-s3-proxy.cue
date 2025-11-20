package kube

k: Secret: "rclone-config": stringData: "rclone.conf": """
	[remote]
	type = smb
	host = 10.0.0.208
	user = longhorn
	pass = 82a0fJnF9qUb4Vd62IkvJoNChM1-zF9SPlShZtjQumP_r7G8
	"""

k: Secret: "longhorn-backup-creds": stringData: {
	AWS_ACCESS_KEY_ID:     "testtest"
	AWS_SECRET_ACCESS_KEY: "testtest"
	AWS_ENDPOINTS:         "http://rclone-smb-s3-proxy.longhorn-system.svc.cluster.local:8080"
}

k: Deployment: "rclone-smb-s3-proxy": spec: template: spec: {
	containers: [{
		image: "nixery.dev/rclone"
		command: [
			"rclone",
			"serve",
			"s3",
			"--addr=:8080",
			"--auth-key=$(AWS_ACCESS_KEY_ID),$(AWS_SECRET_ACCESS_KEY)",
			"remote:/",
		]
		ports: [{
			name:          "http"
			containerPort: 8080
		}]
		envFrom: [{
			secretRef: name: "longhorn-backup-creds"
		}]
		env: [{
			name:  "HOME"
			value: "/home/rclone"
		}]
		volumeMounts: [{
			name:      "config"
			mountPath: "/home/rclone/.config/rclone"
		}]
	}]
	volumes: [{
		name: "config"
		secret: secretName: "rclone-config"
	}]
}

k: Service: "rclone-smb-s3-proxy": {}
