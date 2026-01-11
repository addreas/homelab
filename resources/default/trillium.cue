package kube

k: StatefulSet: trillium: spec: {
	template: spec: containers: [{
		image: "ghcr.io/triliumnext/trilium:\(githubReleases["triliumnext/trilium"])"
		command: ["node", "./src/main"]
		env: [{
			name:  "TRILIUM_DATA_DIR"
			value: "/data"
		}]
		ports: [{
			containerPort: 8080
			name:          "http"
		}]
		volumeMounts: [{
			mountPath: "/data"
			name:      "data"
		}]
		resources: {
			limits: {
				cpu:    "100m"
				memory: "1Gi"
			}
			requests: {
				cpu:    "5m"
				memory: "128Mi"
			}
		}
	}]
	volumeClaimTemplates: [{
		metadata: name: "data"
		spec: {
			accessModes: ["ReadWriteOnce"]
			resources: requests: storage: "5Gi"
		}
	}]
}

k: Service: trillium: {}
k: Ingress: trillium: {}
