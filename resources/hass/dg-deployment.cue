package kube

Labels: app: "boat-trip"

k: Deployment: "boat-trip": {
	_selector: Labels
	spec: {
		replicas: 1
		template: {
			spec: {
				containers: [{
					name:  "dg-exporter"
					image: "ghcr.io/jonasdahl/dg-to-mqtt:latest"
					env: [{
						name:  "DEPARTURE_TIME"
						value: "2021-05-27 20:15:00.000+02:00"
					}, {
						name:  "INTERVAL_SECONDS"
						value: "120"
					}, {
						name:  "ROUTE"
						value: "NYVI"
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
