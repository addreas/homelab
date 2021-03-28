package kube

k: StatefulSet: "hass-postgres": {
	spec: {
		template: spec: {
			containers: [{
				name:  "postgres"
				image: "postgres:13"
				envFrom: [{secretRef: name: "hass-postgres-credentials"}]
				env: [{
					name:  "POSTGRES_DB"
					value: "hass"
				}]
				ports: [{containerPort: 5432}]
				volumeMounts: [{
					name:      "data"
					mountPath: "/var/lib/postgresql"
					subPath:   "data"
				}]
			}]
		}
		volumeClaimTemplates: [{
			metadata: name: "data"
			spec: {
				accessModes: ["ReadWriteOnce"]
				resources: requests: storage: "5Gi"
			}
		}]
	}
}

k: Service: "hass-postgres": {
	_selector: app: "hass-postgres"
	spec: ports: [{
		name: "postgres"
		port: 5432
	}]
}
