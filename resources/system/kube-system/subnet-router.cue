package kube

k: StatefulSet: "tailscale-subnet-router": spec: template: spec: {
	serviceAccountName: "tailscale"
	containers: [{
		name:            "tailscale"
		imagePullPolicy: "Always"
		image:           "ghcr.io/tailscale/tailscale:stable"
		tty:             true
		env: [{
			name:  "TS_KUBE_SECRET"
			value: "tailscale-state"
		}, {
			name:  "TS_USERSPACE"
			value: "true"
		}, {
			name:  "TS_ROUTES"
			value: "10.96.0.0/12,10.0.0.0/16"
		}]
	}]
}

k: ServiceAccount: tailscale: {}
k: RoleBinding: tailscale: {}
k: Role: tailscale: rules: [{
	apiGroups: [""]
	resources: ["secrets"]
	verbs: ["create"]
}, {
	apiGroups: [""]
	resourceNames: ["tailscale-state"]
	resources: ["secrets"]
	verbs: ["get", "update"]
}]
