package kube

namespace: "default"

k: Deployment: "nixery": spec: template: spec: {
	containers: [{
		image: "ghcr.io/addreas/nixery:latest"
		_env: {
			PORT: value:                   "8080"
			NIXERY_FLAKE: value:           "nixpkgs"
			NIXERY_STORAGE_BACKEND: value: "filesystem"
			STORAGE_PATH: value:           "/var/storage"
		}
		env: [for key, value in _env {value & {name: key}}]
		ports: [{
			name:          "http"
			containerPort: 8080
		}]
		volumeMounts: [{
			name:      "storage"
			mountPath: "/var/storage"
			subPath:   "storage"
		}, {
			name:      "storage"
			mountPath: "/nixery"
			subPath:   "nixery"
		}, {
			name:      "storage"
			mountPath: "/nix/var/log"
			subPath:   "nix/var/log"
		}]
	}]
	volumes: [{
		name: "storage"
		persistentVolumeClaim: claimName: "sergio-nixery"
	}]
}

k: Deployment: "nixery-test-deploy": spec: template: spec: containers: [{
	image: "nixery.addem.se/shell"
	command: ["tail", "-f", "/dev/null"]
}]

k: PersistentVolumeClaim: "sergio-nixery": spec: resources: requests: storage: "100Gi"
k: PersistentVolume: "sergio-nixery": spec: local: path: "/mnt/solid-data/nixery"

k: Service: "nixery": {}
k: Ingress: "nixery": {}
