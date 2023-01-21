package kube

import (
	"encoding/json"
	"github.com/addreas/homelab/util"
)

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

k: Deployment: esphome: spec: template: metadata: {
	annotations: "v1.multus-cni.io/default-network": "default/macvlan-conf"
	// annotations: "k8s.v1.cni.cncf.io/networks": "macvlan-conf"
	annotations: "k8s.v1.cni.cncf.io/networks": json.Marshal([{
		"name": "cilium"
		"default-route": []
	}])
}

k: Deployment: esphome: spec: template: spec: {
	initContainers: [util.copyStatic & {
		volumeMounts: [{
			name:      "config"
			mountPath: "/config"
		}, {
			name:      "esphome-configs"
			mountPath: "/static/config"
		}]
	}]
	containers: [{
		image: "esphome/esphome:\(githubReleases["esphome/esphome"])"
		ports: [{containerPort: 6052}]
		volumeMounts: [{
			name:      "config"
			mountPath: "/config"
		}, {
			name:      "root-pio"
			mountPath: "/.platformio"
		}]
	}]
	volumes: [{
		name: "config"
		emptyDir: {}
	}, {
		name: "root-pio"
		emptyDir: {}
	}, {
		name: "esphome-configs"
		projected: sources: [{
			secret: name: "esphome-secrets"
		}, {
			configMap: name: "esphome-configs"
		}]
	}]
}

k: Service: esphome: {}

k: Ingress: esphome: _authproxy: true
