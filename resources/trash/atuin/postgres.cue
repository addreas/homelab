package kube

k: StatefulSet: postgres: spec: {
	template: spec: containers: [{
		image: "postgres:17"
		ports: [{name: "postgres", containerPort: 5432}]
		envFrom: [{
			secretRef: name: "postgres-config"
		}]
		lifecycle: preStop: exec: command: ["/bin/sh", "-c", "pg_ctl stop -D /var/lib/postgresql/data -w -t 60 -m fast"]
		readinessProbe: exec: command: ["/bin/sh", "-c", "pg_isready -U $(POSTGRES_USERNAME)"]
		livenessProbe: exec: command: ["/bin/sh", "-c", "pg_isready -U $(POSTGRES_USERNAME)"]
		resources: {
			requests: {
				cpu:    "100m"
				memory: "100Mi"
			}
			limits: {
				cpu:    "250m"
				memory: "600Mi"
			}
		}
		volumeMounts: [{
			mountPath: "/var/lib/postgresql/data/"
			name:      "data"
		}]
	}]
	volumeClaimTemplates: [{
		metadata: name: "data"
		spec: {
			accessModes: ["ReadWriteOnce"]
			resources: requests: storage: "5Gi"
		}
	}]
}

k: Service: postgres: {}
