package kube

k: Ingress: ecoview: _authproxy: true

k: Service: ecoview: spec: ports: [{
	name: "http"
}]

k: StatefulSet: "ecoview": spec: {
	template: spec: {
		imagePullSecrets: [{name: "regcred"}]
		initContainers: [{
			name:            "migrations"
			image:           "ghcr.io/jonasdahl/ecoview:main"
			imagePullPolicy: "Always"
			command: ["npm", "run", "prisma", "migrate", "deploy"]
			volumeMounts: [{
				name:      "data"
				mountPath: "/var/lib/data"
			}]
			env: [{
				name:  "DATABASE_URL"
				value: "file:/var/lib/data/prod.db"
			}]
		}]
		containers: [{
			image:           "ghcr.io/jonasdahl/ecoview:main"
			imagePullPolicy: "Always"
			ports: [{containerPort: 3000}]
			readinessProbe: {
				httpGet: {
					path: "/"
					port: 3000
				}
				initialDelaySeconds: 2
				failureThreshold:    6
				periodSeconds:       5
			}
			livenessProbe: {
				httpGet: {
					path: "/"
					port: 3000
				}
				initialDelaySeconds: 30
				failureThreshold:    3
				periodSeconds:       120
			}
			volumeMounts: [{
				name:      "data"
				mountPath: "/var/lib/data"
			}]
			env: [{
				name:  "DATABASE_URL"
				value: "file:/var/lib/data/prod.db"
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
