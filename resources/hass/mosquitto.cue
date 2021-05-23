package kube

MosquittoLabels: app: "mosquitto"

k: StatefulSet: mosquitto: {
	spec: {
		template: {
			spec: {
				volumes: [{
					name: "config"
					configMap: name: "mosquitto-config"
				}]
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
					}]
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

k: Service: mosquitto: {
	_selector: app: "mosquitto"
	spec: {
		ports: [{
			name: "tcp0"
			port: 1883
		}, {
			name: "tcp1"
			port: 9001
		}]
	}
}

k: ConfigMap: "mosquitto-config": data: "mosquitto.conf": """
	persistence false
	log_dest stdout
	allow_anonymous true
	connection_messages true
	listener 1883 0.0.0.0
	
	"""
