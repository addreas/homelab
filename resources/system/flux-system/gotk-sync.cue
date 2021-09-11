package kube

k: GitRepository: "homelab": spec: {
	interval: "1m0s"
	ref: branch: "main"
	url: "https://github.com/addreas/homelab"
}

k: CueBuild: "homelab": spec: {
	interval: "5m0s"
	healthChecks: [{
		kind:      "StatefulSet"
		name:      "bitwarden"
		namespace: "default"
	}, {
		kind:      "StatefulSet"
		name:      "unifi-controller"
		namespace: "default"
	}, {
		kind:      "StatefulSet"
		name:      "bazarr"
		namespace: "default"
	}, {
		kind:      "StatefulSet"
		name:      "hass"
		namespace: "default"
	}, {
		kind:      "StatefulSet"
		name:      "hass-postgres"
		namespace: "default"
	}, {
		kind:      "Deployment"
		name:      "hass-zwavejs"
		namespace: "default"
	}, {
		kind:      "StatefulSet"
		name:      "jackett"
		namespace: "default"
	}, {
		kind:      "StatefulSet"
		name:      "qbittorrent"
		namespace: "default"
	}, {
		kind:      "StatefulSet"
		name:      "radarr"
		namespace: "default"
	}, {
		kind:      "StatefulSet"
		name:      "sonarr"
		namespace: "default"
	}, {
		kind:      "StatefulSet"
		name:      "yanzi-gateway"
		namespace: "default"
	}]
	packages: [
		"./resources/bitwarden",
		"./resources/default",
		"./resources/fogis",
		"./resources/grrrr",
		"./resources/hass",
		"./resources/monitoring",
		"./resources/unifi",
		"./resources/system/cert-manager",
		"./resources/system/flux-system",
		"./resources/system/kpack",
		"./resources/system/kube-system",
		"./resources/system/longhorn-system",
	]
	prune: true
	sourceRef: {
		kind: "GitRepository"
		name: "homelab"
	}
	validation: "client"
}
