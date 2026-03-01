package kube

k: StatefulSet: "redis": spec: {
	template: spec: {
		containers: [{
			image: "docker.io/library/redis:8"
			ports: [{
				name:          "redis"
				containerPort: 6379
			}]
			volumeMounts: [{
				name:      "data"
				mountPath: "/data"
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
k: Service: "redis": spec: {}
