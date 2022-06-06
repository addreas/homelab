package kube

import (
	"crypto/md5"
	"encoding/hex"
)

k: Ingress: mqtt: {
	metadata: annotations: {
		"ingress.kubernetes.io/ssl-passthrough": "true"
	}
	spec: {
		rules: [{
			host: "mqtt.addem.se"
			http: paths: [{
				path:     "/"
				pathType: "Prefix"
				backend: service: {
					name: "mosquitto"
					port: { name: "ws" }
				}
			}]
		}]
	}
}

k: Service: mosquitto: spec: {
	ports: [{
		name: "tcp0"
		port: 1883
	}, {
		name: "ws"
		port: 9001
	}]
}

k: StatefulSet: mosquitto: {
	spec: {
		template: {
			metadata: labels: "config-hash": hex.Encode(md5.Sum(k.ConfigMap."mosquitto-config".data."mosquitto.conf"))
			spec: {
				containers: [{
					name:  "mosquitto"
					image: "eclipse-mosquitto:latest"
					ports: [{containerPort: 1883}, {containerPort: 9001}]
					volumeMounts: [{
						name:      "data"
						mountPath: "/mosquitto/data"
					}, {
						mountPath: "/mosquitto/config"
						name:      "config"
					}, {
						mountPath: "/certs"
						name:      "certs"
					}]
				}]
				volumes: [{
					name: "config"
					configMap: name: "mosquitto-config"
				}, {
					name: "certs"
					secret: secretName: "mqtt-mosquitto-cert"
				}]
			}
		}
		volumeClaimTemplates: [{
			metadata: name: "data"
			spec: {
				accessModes: ["ReadWriteOnce"]
				resources: requests: storage: "1Gi"
			}
		}]
	}
}

k: ConfigMap: "mosquitto-config": data: "mosquitto.conf": """
	# this will listen for mqtt on tcp
	listener 1883
	protocol mqtt
	cafile /certs/ca.crt
	certfile /certs/tls.crt
	keyfile /certs/tls.key
	require_certificate true
	allow_anonymous false
	use_identity_as_username true

	# this will expect websockets connections
	listener 9001
	protocol websockets
	cafile /certs/ca.crt
	certfile /certs/tls.crt
	keyfile /certs/tls.key
	require_certificate true
	allow_anonymous false
	use_identity_as_username true

	log_type error
	log_type warning
	"""
