package kube

k: Deployment: "rclone-cnpg-s3-proxy": spec: template: spec: {
	containers: [{
		image: "nixery.dev/rclone"
		command: [
			"rclone",
			"serve",
			"s3",
			"--addr=:8080",
			"--auth-key=$(AWS_ACCESS_KEY_ID),$(AWS_SECRET_ACCESS_KEY)",
			"remote:/Backups",
		]
		ports: [{
			name:          "http"
			containerPort: 8080
		}]
		envFrom: [{
			secretRef: name: "rclone-cnpg-backup-creds"
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
		secret: secretName: "rclone-cnpg-config"
	}]
}

k: Service: "rclone-cnpg-s3-proxy": {}
