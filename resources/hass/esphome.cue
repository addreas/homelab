package kube

k: Deployment: "esphome": {
	spec: {
		template: {
			spec: {
				containers: [{
					name:  "esphome"
					image: "esphome/esphome:\(githubReleases["esphome/esphome"])"
					ports: [{containerPort: 6052}]
					volumeMounts: [{
					// 	name:      "esphome-configs"
					// 	mountPath: "/config"
					// }, {
					// 	name: "esphome-secrets"
					// 	mountPath: "/config/secrets.yaml"
					// 	subPath: "secrets.yaml"
					// }, {
						name: "platformio-cache"
						mountPath: "/config/.esphome/platformio"
						subPath: "esphome-platformio-cache"
					}]
				}]
				volumes: [{
					name: "platformio-cache"
					nfs: {
						server: "sergio.localdomain"
						path: "/export/backups"
					}
				}]
			}
		}
	}
}

k: Service: "esphome": {}

k: Ingress: "esphome": _authproxy: true