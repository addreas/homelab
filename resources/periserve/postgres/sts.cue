package kube

k: StatefulSet: postgres: spec: {
	template: spec: {
		securityContext: fsGroupChangePolicy: "Always"
		containers: [{
			name:  "postgres"
			image: "postgres:14"
			env: [
				{name: "POSTGRES_USER", value:     "johndoe"},
				{name: "POSTGRES_PASSWORD", value: "randompasswordright"},
				{name: "POSTGRES_DB", value:       "mydb"},
			]
			ports: [{containerPort: 5432}]
			readinessProbe: tcpSocket: port: 5432
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
			resources: requests: storage: "3Gi"
		}
	}]
}
