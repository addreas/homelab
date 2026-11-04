package kube

_namespace: "hass"

k: CueExport: "homelab-hass": spec: {
	paths: ["./resources/hass"]
	prune:   true
	suspend: false
	decryption: {
		provider: "sops"
		secretRef: name: "qb-homelab"
	}
}
