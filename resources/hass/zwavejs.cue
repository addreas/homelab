package kube

import (
	"strings"
	"crypto/md5"
	"encoding/hex"
	"github.com/addreas/homelab/util"
)

k: StatefulSet: "hass-zwavejs": {
	spec: {
		template: {
			metadata: labels: "config-hash": hex.Encode(md5.Sum(k.ConfigMap."zwave-js-settings-json".data."settings.json"))
			spec: {
				initContainers: [util.copyStatic & {
					volumeMounts: [{
						name:      "config"
						mountPath: "/usr/src/app/store"
					}, {
						name:      "store-settings-json"
						mountPath: "/static/usr/src/app/store/settings.json"
						subPath:   "settings.json"
					}]
				}]
				containers: [{
					name:  "zwavejs"
					image: "ghcr.io/zwave-js/zwave-js-ui:\(strings.TrimPrefix(githubReleases["zwave-js/zwave-js-ui"], "v"))"
					ports: [{containerPort: 3000}, {containerPort: 8091}]
					env: [{
						name: "NETWORK_KEY"
						valueFrom: secretKeyRef: {
							name: "zwave-network-key"
							key:  "key"
						}
					}]
					resources: limits: "addem.se/dev_aeotec_zstick": "1"
					volumeMounts: [{
						name:      "config"
						mountPath: "/usr/src/app/store"
						// }, {
						//  name:      "store-settings-json"
						//  mountPath: "/usr/src/app/store/settings.json"
						//  subPath:   "settings.json"
					}]
				}]
				volumes: [{
					name: "store-settings-json"
					configMap: name: "zwave-js-settings-json"
				}]
			}
		}
		volumeClaimTemplates: [{
			metadata: name: "config"
			spec: {
				accessModes: ["ReadWriteOnce"]
				resources: requests: storage: "1Gi"
			}
		}]
	}
}

k: Service: "hass-zwavejs": spec: ports: [{
	name: "http"
	port: 8091
}, {
	name: "websocket"
	port: 3000
}]
