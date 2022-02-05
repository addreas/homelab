package kube

k: StatefulSet: postgres: spec: {
	template: spec: {
		securityContext: fsGroupChangePolicy: "Always"
		containers: [{
			name:  "postgres"
			image: "postgres:13"
			envFrom: [
				{secretRef: name:    "postgres-credentials"},
				{configMapRef: name: "postgres-config"},
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
			resources: requests: storage: "5Gi"
		}
	}]
}

k: Service: postgres: spec: ports: [{
	name: "postgres"
	port: 5432
}]
