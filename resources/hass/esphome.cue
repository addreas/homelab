package kube

import (
	"encoding/json"
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

k: Deployment: esphome: spec: strategy: type: "Recreate"

k: Deployment: esphome: spec: template: metadata:
	annotations: "k8s.v1.cni.cncf.io/networks": json.Marshal([{
		name: "macvlan-conf"
		mac:  "02:00:00:00:00:07" // https://en.wikipedia.org/wiki/MAC_address#IEEE_802c_local_MAC_address_usage
	}])

k: Deployment: esphome: spec: template: spec: {
	initContainers: [
		util.macvlanDefaultRouteFix,
		util.copyStatic & {
			volumeMounts: [{
				name:      "config"
				mountPath: "/config"
			}, {
				name:      "esphome-configs"
				mountPath: "/static/config"
			}]
		},
	]
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
	terminationGracePeriodSeconds: 0
}

k: Service: esphome: {}

k: Ingress: esphome: _authproxy: true
