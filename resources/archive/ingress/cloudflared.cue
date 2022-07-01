package kube

import "encoding/yaml"

k: Deployment: cloudflared: spec: {
	replicas: 2
	template: spec: {
		containers: [{
			image: "cloudflare/cloudflared:2022.6.3"
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

// cloudflared tunnel login
// cloudflared tunnel create nucles-ingress # prints tunnel UUID
// kubectl create secret generic --dry-run=client -o yaml cloudflared-credentials \
//   --from-file ~/.cloudflared/cert.pem \
//   --from-file ~/.cloudflared/d8e11b22-80ad-42ef-9c8b-92992118e669.json \
//   | cue import-yaml > cloudflared-secret.cue
// cue seal
// rm cloudflared-secret.cue
// cloudflared tunnel route dns d8e11b22-80ad-42ef-9c8b-92992118e669 "*.addem.se"
// cloudflared tunnel route dns d8e11b22-80ad-42ef-9c8b-92992118e669 "addem.se"

k: ConfigMap: "cloudflared-config": data: "config.yaml": yaml.Marshal({
	tunnel:             "d8e11b22-80ad-42ef-9c8b-92992118e669"
	"credentials-file": "/etc/cloudflared/credentials.json"
	"no-autoupdate":    true
	ingress: [{
		// service:  "http://skipper-ingress:9999"
		service:     "https://haproxy-haproxy-ingress.kube-system.svc.cluster.local"
		noTLSVerify: true
	}]
})
