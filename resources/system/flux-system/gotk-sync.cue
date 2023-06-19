package kube

k: GitRepository: "homelab": spec: {
	url: "https://github.com/addreas/homelab"
	ref: branch: "main"
}

k: CueExport: "homelab-system": spec: {
	interval: "30m"
	paths: [
		"./resources/system/cert-manager",
		"./resources/system/flux-system",
		"./resources/system/ingress",
		"./resources/system/kube-system",
		"./resources/system/longhorn-system",
		"./resources/system/monitoring",
		"./resources/system/lauset",
	]
	prune:     false
	sourceRef: _homelab
}

k: Receiver: "homelab": spec: {
	type: "github"
	events: ["ping", "push"]
	secretRef: name: "homelab-receiver-webhook-token"
	resources: [_homelab]
}
