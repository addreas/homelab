package kube

namespace: "default"

k: Deployment: "nixery": spec: template: spec: {
	containers: [{
		image: "ghcr.io/addreas/nixery@sha256:2d026095e5968a7cdbc42339f7e17f8c264fd5d372c76439cacb2759025a3602"
		_env: {
			PORT: value:                   "8080"
			NIXERY_FLAKE: value:           "nixpkgs"
			NIXERY_STORAGE_BACKEND: value: "filesystem"
			NIXERY_STORAGE_PATH: value:    "/nixery/storage"
			NIXERY_CACHE_URL: value:       "/nixery/cache"
			NIXPKGS_ALLOW_INSECURE: value: "1"
		}
		env: [for key, value in _env {value & {name: key}}]
		ports: [{
			name:          "http"
			containerPort: 8080
		}]
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
