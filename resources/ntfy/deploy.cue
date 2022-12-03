package kube

import "encoding/yaml"

k: Deployment: ntfy: spec: template: spec: {
	containers: [{
		image: "binwiederhier/ntfy"
		// command: ["sleep", "10000"]
		args: ["serve"]
		ports: [{containerPort: 8080}]
		volumeMounts: [{
			name:      "config"
			mountPath: "/etc/ntfy"
		}, {
			name:      "secrets"
			mountPath: "/var/lib/ntfy"
		}]
	}]
	volumes: [{
		name: "config"
		configMap: name: "ntfy"
	}, {
		name: "secrets"
		secret: secretName: "ntfy"
	}]
}

k: ConfigMap: ntfy: data: "server.yml": yaml.Marshal({
	"base-url":             "https://ntfy.addem.se"
	"listen-http":          ":8080"
	"firebase-key-file":    "/var/lib/ntfy/google-sa-key.json" // https://console.firebase.google.com/u/0/project/hass-dke/settings/serviceaccounts/adminsdk
	"behind-proxy":         true
	"auth-file":            "/var/lib/ntfy/user.db"
	"auth-default-access":  "deny-all"
	"attachment-cache-dir": "/tmp"
})

k: Service: ntfy: {}

k: Ingress: ntfy: {}

// podman run --name=ntfy-tmp -e NTFY_AUTH_FILE=/user.db -d binwiederhier/ntfy serve
// podman exec ntfy-tmp ntfy user add --role=admin addem
// podman cp ntfy-tmp:/user.db .
