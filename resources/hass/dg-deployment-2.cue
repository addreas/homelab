package kube

Labels: app: "boat-trip-2"

k: Deployment: "boat-trip-2": {
	_selector: Labels
	spec: {
		replicas: 1
		template: {
			spec: {
				containers: [{
					name:  "dg-exporter"
					image: "ghcr.io/jonasdahl/dg-to-mqtt:latest"
					env: [{
						name:  "TZ"
						value: "Europe/Stockholm"
					}, {
						name:  "DEPARTURE_TIME"
						value: "2021-05-31 17:10:00.000+02:00"
					}, {
						name:  "INTERVAL_SECONDS"
						value: "120"
					}, {
						name:  "ROUTE"
						value: "VINY"
					}, {
						name:  "PASSENGERS"
						value: "adult,under25,car"
					}, {
						name:  "MQTT_BROKER_URL"
						value: "tcp://mosquitto.default.svc.cluster.local:1883"
					}]
				}]
			}
		}
	}
}
