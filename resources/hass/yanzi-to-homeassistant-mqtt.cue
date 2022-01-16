package kube

k: StatefulSet: "hass-yanzi-to-homeassistant-mqtt": {
	spec: {
		template: {
			spec: {
				containers: [{
					name:  "yanzi-to-homeassistant-mqtt"
					image: "ghcr.io/jonasdahl/yanzi-to-homeassistant-mqtt@sha256:38373b45f3c1c06d9489fbe1d3776223868e655cf876d61df8d68566116ffb3a"
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
