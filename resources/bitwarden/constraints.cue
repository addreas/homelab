package kube

_namespace: "bitwarden"

k: [string]: [string]: metadata: labels: app: "bitwarden"

k: CueExport: "homelab-bitwarden": spec: {
	interval:  "30m"
	sourceRef: _homelab
	paths: ["./resources/bitwarden"]
	prune:   false
	suspend: false
	decryption: {
		provider: "sops"
		secretRef: name: "qb-homelab"
	}
}
