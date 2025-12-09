package kube

import (
	"encoding/json"
	"github.com/addreas/homelab/util"
)

k: GitRepository: "esphome-configs": spec: url: "https://github.com/jonasdahl/esphome.git"

k: Kustomization: "esphome-configs": {
	metadata: namespace: string
	spec: {
		sourceRef: name: "esphome-configs"
		targetNamespace: metadata.namespace
	}
}

k: StatefulSet: esphome: spec: {
	template: metadata: annotations: "k8s.v1.cni.cncf.io/networks": json.Marshal([{
		name: "macvlan-conf"
		mac:  "02:00:00:00:00:07" // https://en.wikipedia.org/wiki/MAC_address#IEEE_802c_local_MAC_address_usage
	}])

	template: spec: {
		initContainers: [
			util.macvlanDefaultRouteFix,
			util.copyStatic & {
				volumeMounts: [{
					name:      "data"
					mountPath: "/config"
					subPath:   "config"
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
				name:      "data"
				mountPath: "/config"
				subPath:   "config"
			}, {
				name:      "data"
				mountPath: "/.platformio"
				subPath:   ".platformio"
			}, {
				name:      "data"
				mountPath: "/piolibs"
				subPath:   "piolibs"
			}, {
				name:      "data"
				mountPath: "/.cache"
				subPath:   "cache"
			}]
		}]
		volumes: [{
			name: "esphome-configs"
			projected: sources: [{
				secret: name: "esphome-secrets"
			}, {
				configMap: name: "esphome-configs"
			}]
		}]
		terminationGracePeriodSeconds: 0
	}
	volumeClaimTemplates: [{
		metadata: name: "data"
		spec: {
			accessModes: ["ReadWriteOnce"]
			resources: requests: storage: "5Gi"
		}
	}]
}

k: Service: esphome: {}

k: Ingress: esphome: _authproxy: true
