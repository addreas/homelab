package kube

import (
	// "encoding/json"
	"github.com/addreas/homelab/util"
)

k: GitRepository: homelab: spec: {
	url: "https://github.com/addreas/homelab"
	ref: branch: "main"
}

k: GitRepository: "esphome-configs": spec: url: "https://github.com/jonasdahl/esphome.git"

k: Kustomization: "esphome-configs": {
	metadata: namespace: string
	spec: {
		sourceRef: name: "esphome-configs"
		targetNamespace: metadata.namespace
	}
}

k: Deployment: esphome: spec: template: metadata: annotations: "k8s.v1.cni.cncf.io/networks": "macvlan-conf"

k: Deployment: esphome: spec: template: spec: {
	initContainers: [util.copyStatic & {
		volumeMounts: [{
			name:      "config"
			mountPath: "/config"
		}, {
			name:      "esphome-configs"
			mountPath: "/static/config"
		}]
	}, {
		name:  "default-route"
		image: "nixery.dev/iproute2"
		command: ["ip", "route", "delete", "default", "via", "192.168.1.1"]
		securityContext: capabilities: add: ["NET_ADMIN"]
	}]
	containers: [{
		image: "esphome/esphome:\(githubReleases["esphome/esphome"])"
		ports: [{containerPort: 6052}]
		volumeMounts: [{
			name:      "config"
			mountPath: "/config"
		}, {
			name:      "root"
			mountPath: "/.platformio"
			subPath:   ".platformio"
		}, {
			name:      "root"
			mountPath: "/piolibs"
			subPath:   "piolibs"
		}]
	}]
	volumes: [{
		name: "config"
		emptyDir: {}
	}, {
		name: "root"
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
