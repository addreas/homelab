package kube

k: StatefulSet: "hass-postgres-new": spec: {
	template: spec: containers: [{
		name:  "postgres"
		image: "postgres:17"
		envFrom: [{secretRef: name: "hass-postgres-credentials"}]
		env: [{
			name:  "POSTGRES_DB"
			value: "hass"
		}]
		ports: [{name: "postgres", containerPort: 5432}]
		volumeMounts: [{
			name:      "data"
			mountPath: "/var/lib/postgresql"
			subPath:   "data"
		}]
	}]
	volumeClaimTemplates: [{
		metadata: name: "data"
		spec: {
			accessModes: ["ReadWriteOnce"]
			resources: requests: storage: "10Gi"
		}
	}]
}

k: Service: "hass-postgres-new": {}
