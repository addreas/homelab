package kube

namespace: "default"

k: Deployment: "nixery": spec: template: spec: {
	containers: [{
		image: "ghcr.io/addreas/nixery@sha256:371a5cc5078138b550ac0d3190443d1d0b871a8b2ef27b3e7a87501f5f63b100 "
		_env: {
			PORT: value:                   "8080"
			NIXERY_FLAKE: value:           "nixpkgs"
			NIXERY_STORAGE_BACKEND: value: "filesystem"
			NIXERY_STORAGE_PATH: value:    "/nixery/storage"
			NIXERY_CACHE_URL: value:       "/nixery/cache"
			NIXERY_TIMEOUT: value:         "300"
			NIXPKGS_ALLOW_INSECURE: value: "1"
		}
		env: [for key, value in _env {value & {name: key}}]
		ports: [{
			name:          "http"
			containerPort: 8080
		}]
		resources: limits: memory: "2Gi"
		volumeMounts: [{
			name:      "storage"
			mountPath: "/nixery"
		}]
	}]
	volumes: [{
		name: "storage"
		persistentVolumeClaim: claimName: "sergio-nixery"
	}]
}

k: PersistentVolumeClaim: "sergio-nixery": spec: resources: requests: storage: "100Gi"
k: PersistentVolume: "sergio-nixery": spec: local: path: "/mnt/solid-data/nixery"

k: Service: "nixery": {}
k: Ingress: "nixery": {}

k: Ingress: "nixery": metadata: annotations:
	"haproxy-ingress.github.io/timeout-server": "300s"
