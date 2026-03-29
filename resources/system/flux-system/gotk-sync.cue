package kube

k: GitRepository: "homelab": spec: {
	url: "https://github.com/addreas/homelab"
	ref: branch: "qb"
}

k: CueExport: "homelab-system": spec: {
	interval: "30m"
	paths: [
		"./resources/system/cert-manager",
		"./resources/system/flux-system",
		// "./resources/system/ingress",
		"./resources/system/kube-system",
		"./resources/system/longhorn-system",
		// "./resources/system/monitoring",
		"./resources/system/lauset",
		// "./resources/system/nixery",
	]
	prune: false
	decryption: {
		provider: "sops"
		secretRef: name: "qb-homelab"
	}
	sourceRef: _homelab
}

k: Receiver: "homelab": spec: {
	type: "github"
	events: ["ping", "push"]
	secretRef: name: "homelab-receiver-webhook-token"
	resources: [_homelab]
}
