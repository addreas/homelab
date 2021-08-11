package kube

import (
	"crypto/md5"
	"encoding/hex"
)

k: Deployment: "hass-zwavejs": {
	spec: {
		strategy: type: "Recreate"
		template: {
			metadata: labels: "config-hash": hex.Encode(md5.Sum(k.ConfigMap."zwave-js-settings-json".data."settings.json"))
			spec: {
				containers: [{
					name:  "zwavejs"
					image: "zwavejs/zwavejs2mqtt:5.1.0"
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
					}, {
						name:      "store-settings-json"
						mountPath: "/usr/src/app/store/settings.json"
						subPath:   "settings.json"
					}]
				}]
				volumes: [{
					name: "config"
					emptyDir: {}
				}, {
					name: "store-settings-json"
					configMap: name: "zwave-js-settings-json"
				}]
			}
		}
	}
}

k: Service: "hass-zwavejs": {
	_selector: app: "hass-zwavejs"
	spec: ports: [{
		name: "http"
		port: 8091
	}, {
		name: "websocket"
		port: 3000
	}]
}
