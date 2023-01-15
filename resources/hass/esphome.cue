package kube

k: GitRepository: homelab: spec: {
	url: "https://github.com/addreas/homelab"
	ref: branch: "main"
}

k: GitRepository: "esphome-configs": spec: {
	url: "https://github.com/jonasdahl/esphome.git"
	include: [{
		repository: name: "homelab"
		fromPath: "resources/hass/esphome"
		toPath:   "/"
	}]
}
k: Kustomization: "esphome-configs": spec: sourceRef: name: "esphome-configs"

k: Deployment: esphome: spec: template: spec: {
	containers: [{
		image: "esphome/esphome:\(githubReleases["esphome/esphome"])"
		ports: [{containerPort: 6052}]
		volumeMounts: [{
			name:      "esphome-configs"
			mountPath: "/config"
		}, {
			name:      "esphome-secrets"
			mountPath: "/config/secrets.yaml"
			subPath:   "secrets.yaml"
		}, {
			name:      "platformio-cache"
			mountPath: "/config/.esphome/platformio"
			subPath:   "esphome-platformio-cache"
		}]
	}]
	volumes: [{
		name: "esphome-configs"
		configMap: name: "esphome-configs"
	}, {
		name: "esphome-secrets"
		secret: secretName: "esphome-secrets"
	}, {
		name: "platformio-cache"
		nfs: {
			server: "sergio.localdomain"
			path:   "/export/backups"
		}
	}]
}

k: Service: esphome: {}

k: Ingress: esphome: _authproxy: true
