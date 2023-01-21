package kube

import (
	// "encoding/json"
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
	// annotations: "k8s.v1.cni.cncf.io/networks": json.Marshal([{
	//  "name": "cilium"
	//  "default-route": []
	// }])
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
	dnsPolicy: "None"
	dnsConfig: {
		nameservers: ["192.168.1.1"]
		searches: ["localdomain"]
	}
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
		persistentVolumeClaim: claimName: "esphome-build-cache"
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

k: PersistentVolumeClaim: "esphome-build-cache": spec: {
	accessModes: ["ReadWriteMany"]
	resources: requests: storage: "10Gi"
}
