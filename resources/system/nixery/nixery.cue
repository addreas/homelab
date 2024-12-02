package kube

namespace: "default"

k: Deployment: "nixery": spec: template: spec: {
	containers: [{
		image: "ghcr.io/addreas/nixery@sha256:50ddbb4c0bb88920a722926145b148461a6e54f59076be91b1ef1d9d205f7e0c"
		_env: {
			PORT: value:                   "8080"
			NIXERY_FLAKE: value:           "nixpkgs"
			NIXERY_STORAGE_BACKEND: value: "filesystem"
			NIXERY_STORAGE_PATH: value:    "/nixery/storage"
			NIXERY_CACHE_URL: value:       "file:///nixery/cache"
			NIXERY_TIMEOUT: value:         "300"
			NIXPKGS_ALLOW_INSECURE: value: "1"
		}
		env: [for key, value in _env {value & {name: key}}]
		ports: [{
			name:          "http"
			containerPort: 8080
		}]
		resources: limits: memory: "4Gi"
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
