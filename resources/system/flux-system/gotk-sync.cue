package kube

k: GitRepository: "homelab": spec: {
	url: "https://github.com/addreas/homelab"
	ref: branch: "main"
}

k: CueExport: "homelab-system": spec: {
	paths: [
		"./resources/system/cert-manager",
		"./resources/system/cnpg",
		"./resources/system/flux-system",
		"./resources/system/net",
		"./resources/system/ingress",
		"./resources/system/kube-system",
		"./resources/system/runtimes",
		"./resources/system/longhorn-system",
		"./resources/system/lauset",
		// "./resources/system/nixery",
	]
	prune: false
	decryption: {
		provider: "sops"
		secretRef: name: "qb-homelab"
	}
}

k: Receiver: "homelab": spec: {
	type: "github"
	events: ["ping", "push"]
	secretRef: name: "homelab-receiver-webhook-token"
	resources: [k.CueExport."homelab-system".spec.sourceRef]
}
