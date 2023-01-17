package kube

k: GitRepository: homelab: spec: {
	url: "https://github.com/addreas/homelab"
	ref: branch: "main"
}

k: GitRepository: "esphome-configs": spec: {
	url: "https://github.com/jonasdahl/esphome.git"
	include: [{
		repository: name: "homelab"
		fromPath: "/resources/hass/esphome/kustomization.yaml"
		toPath:   "/kustomization.yaml"
	}]
}

k: Kustomization: "esphome-configs": {
	metadata: namespace: string
	spec: {
		sourceRef: name: "esphome-configs"
		targetNamespace: metadata.namespace
	}
}

k: Deployment: esphome: spec: template: spec: {
	containers: [{
		image: "esphome/esphome:\(githubReleases["esphome/esphome"])"
		ports: [{containerPort: 6052}]
		volumeMounts: [{
			name:      "esphome-configs"
			mountPath: "/config"
		}, {
			name:      "build"
			mountPath: "/config/.esphome/build"
		}, {
			name:      "platformio-cache"
			mountPath: "/config/.esphome/platformio"
			subPath:   "esphome-platformio-cache"
		}]
	}]
	volumes: [{
		name: "esphome-configs"
		projected: sources: [{
			secret: name: "esphome-secrets"
		}, {
			configMap: name: "esphome-configs"
		}]
	}, {
		name: "build"
		emptyDir: {}
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
