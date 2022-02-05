package kube

k: StatefulSet: "hass-yanzi-to-homeassistant-mqtt": {
	spec: {
		template: {
			spec: {
				containers: [{
					name:  "yanzi-to-homeassistant-mqtt"
					image: "ghcr.io/jonasdahl/yanzi-to-homeassistant-mqtt@sha256:4f0f769567313d35ae92bcb9dee045af0bdd50da464856675f09d37c43a7bbe7"
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
