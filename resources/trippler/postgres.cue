package kube

k: StatefulSet: "trippler-db": spec: {
	template: spec: {
		securityContext: fsGroupChangePolicy: "Always"
		containers: [{
			name:  "postgres"
			image: "postgres:14"
			envFrom: [
				{secretRef: name: "trippler-secrets"},
				{configMapRef: name: "trippler-env"},
			]
			env: [{name: "POSTGRES_DB", value: "trippler"}]
			ports: [{containerPort: 5432}]
			volumeMounts: [{
				name:      "data"
				mountPath: "/var/lib/postgresql"
				subPath:   "data"
			}]
			readinessProbe: {
				exec: command: ["/bin/sh", "-c", "pg_isready -U postgres"]
				initialDelaySeconds: 20
				failureThreshold:    6
				periodSeconds:       10
			}
			livenessProbe: {
				exec: command: ["/bin/sh", "-c", "pg_isready -U postgres"]
				initialDelaySeconds: 30
				failureThreshold:    3
				periodSeconds:       10
			}
		}]
	}
	volumeClaimTemplates: [{
		metadata: name: "data"
		spec: {
			accessModes: ["ReadWriteOnce"]
			resources: requests: storage: "1Gi"
		}
	}]
}

k: Service: "trippler-db": spec: ports: [{
	name: "trippler-db"
}]
