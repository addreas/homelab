package kube

version: "sha256:13beb29169e062674fd1839594df05e3bdcf18baab826ad451732865affb285f"

k: Deployment: "hass-yanzi-to-homeassistant-mqtt": {
	spec: {
		template: {
			spec: {
				containers: [{
					name:  "yanzi-to-homeassistant-mqtt"
					image: "ghcr.io/jonasdahl/yanzi-to-homeassistant-mqtt@\(version)"
					env: [
						{name: "LOCATION_ID", value:                  "872855"},
						{name: "MQTT_URL", value:                     "wss://mqtt.addem.se/mqtt"},
						{name: "CIRRUS_HOST", value:                  "eu.yanzi.cloud"},
						{name: "LOG_LEVEL", value:                    "debug"},
						{name: "MQTT_CA_PATH", value:                 "/certs/ca.crt"},
						{name: "MQTT_CERT_PATH", value:               "/certs/tls.crt"},
						{name: "MQTT_KEY_PATH", value:                "/certs/tls.key"},
						{name: "MQTT_PROTOCOL", value:                "wss"},
						{name: "NODE_TLS_REJECT_UNAUTHORIZED", value: "0"},
					]
					envFrom: [{secretRef: name: "yanzi-credentials"}]
					volumeMounts: [{
						mountPath: "/certs"
						name:      "certs"
					}]
				}]
				volumes: [{
					name: "certs"
					secret: secretName: "mqtt-switchbot-proxy-cert"
				}]
			}
		}
	}
}
