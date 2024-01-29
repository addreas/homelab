package kube

version: "sha256:e454c8289a64da4e27e91a44e2069ed047e1a13dd92c32366c6e9efa197bb135"

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
