package kube

import "encoding/yaml"

k: Deployment: cloudflared: spec: {
	replicas: 2
	template: spec: {
		containers: [{
			name:  "cloudflared"
			image: "cloudflare/cloudflared:2022.2.0"
			args: [
				"tunnel",
				"--config",
				"/etc/cloudflared/config.yaml",
				"run",
			]
			volumeMounts: [{
				name:      "cloudflared"
				mountPath: "/etc/cloudflared"
			}]
		}]
		volumes: [{
			name: "cloudflared"
			projected: sources: [{
				configMap: name: "cloudflared-config"
			}, {
				secret: name: "cloudflared-credentials"
			}]
		}]
	}
}

k: ConfigMap: "cloudflared-config": data: "config.yaml": yaml.Marshal({
	tunnel:             "uuid"
	"credentials-file": "/etc/cloudflared/credentials.json"
	"no-autoupdate":    true
	ingress: [{
		hostname: "*.addem.se"
		service:  "http://skipper-ingress:9999"
	}, {
		service: "http_status:404"
	}]
})
