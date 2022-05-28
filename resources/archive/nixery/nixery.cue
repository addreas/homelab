package kube

k: Deployment: "nixery": spec: template: spec: {
	containers: [{
		image: "ghcr.io/addreas/nixery:latest"
		env: [ for key, value in _env {value & {name: key}}]
		_env: {
			PORT: value:           "8080"     //HTTP port on which Nixery should listen
			// NIXERY_CHANNEL: value: "unstable" //The name of a Nix/NixOS channel to use for building
			NIXERY_STORAGE_BACKEND: value: "filesystem" //The type of backend storage to use, currently supported values are gcs (Google Cloud Storage) and filesystem.
			STORAGE_PATH: value: "/var/storage"

			NIXERY_PKGS_REPO: value: "https://github.com/NixOS/nixpkgs.git" //URL of a git repository containing a package set (uses locally configured SSH/git credentials)
			// NIXERY_PKGS_PATH: A local filesystem path containing a Nix package set to use for building
			NIX_TIMEOUT: value: "240" //Number of seconds that any Nix builder is allowed to run (defaults to 60)
			// NIX_POPULARITY_URL: URL to a file containing popularity data for the package set (see popcount/)
		}
		ports: [{
			name: "http"
			containerPort: 8080
		}]
		volumeMounts: [{
			name: "storage"
			mountPath: "/var/storage"
			subPath: "nixery"
		}]
	}]
	volumes: [{
		name: "storage"
		nfs: {
			path:   "/export/nfs-csi"
			server: "sergio.localdomain"
		}
	}]
}

// k: Deployment: "nixery-test-deploy": spec: template: spec: containers: [{
// 	image: "nixery.addem.se/shell"
// 	command: ["tail", "-f", "/dev/null"]
// }]

k: Service: "nixery": {}
k: Ingress: "nixery": {}