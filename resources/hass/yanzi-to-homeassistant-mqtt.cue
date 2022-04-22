package kube

k: StatefulSet: "hass-yanzi-to-homeassistant-mqtt": {
	spec: {
		template: {
			spec: {
				containers: [{
					name:  "yanzi-to-homeassistant-mqtt"
					image: "ghcr.io/jonasdahl/yanzi-to-homeassistant-mqtt@sha256:2e3388c6ac530e1960ec54b2e6dd4999fe57987cc0edefa8fd96664fc7c0ec82"
					env: [{
						name:  "LOCATION_ID"
						value: "872855"
					}, {
						name:  "MQTT_URL"
						value: "tcp://mosquitto:1883"
					}, {
						name:  "CIRRUS_HOST"
						value: "eu.yanzi.cloud"
					}, {
						name:  "LOG_LEVEL"
						value: "debug"
					}]
					envFrom: [{secretRef: name: "yanzi-credentials"}]
				}]
			}
		}
	}
}
