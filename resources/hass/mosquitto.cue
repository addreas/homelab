package kube

import (
	"crypto/md5"
	"encoding/hex"
)

k: Deployment: mosquitto: spec: {
	template: {
		metadata: labels: "config-hash": hex.Encode(md5.Sum(k.ConfigMap."mosquitto-config".data."mosquitto.conf"))
		spec: {
			containers: [{
				image: "eclipse-mosquitto:latest"
				ports: [{
					name: "tcp0"
					containerPort: 1883
				}]
				volumeMounts: [{
					mountPath: "/mosquitto/config"
					name:      "config"
				}]
			}]
			volumes: [{
				name: "config"
				configMap: name: "mosquitto-config"
			}]
		}
	}
}

k: Service: mosquitto: {}

k: ConfigMap: "mosquitto-config": data: "mosquitto.conf": """
	persistence false
	log_dest stdout
	connection_messages true

	log_type all

	# MQTT over TCP
	listener 1883
	protocol mqtt
	allow_anonymous true
	"""
