package kube

version: "sha256:13beb29169e062674fd1839594df05e3bdcf18baab826ad451732865affb285f"

k: StatefulSet: "hass-yanzi-to-homeassistant-mqtt": spec: template: spec: {
	containers: [{
		name:  "yanzi-to-homeassistant-mqtt"
		image: "ghcr.io/jonasdahl/yanzi-to-homeassistant-mqtt@\(version)"
		env: [
			{name: "LOCATION_ID", value: "872855"},
			{name: "MQTT_URL", value:    "tcp://mosquitto:1883"},
			{name: "CIRRUS_HOST", value: "eu.yanzi.cloud"},
			{name: "LOG_LEVEL", value:   "debug"},
		]
		envFrom: [{secretRef: name: "yanzi-credentials"}]
	}]
}
