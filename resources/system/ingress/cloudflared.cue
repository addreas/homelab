package kube

import "encoding/yaml"

k: Deployment: cloudflared: spec: {
	replicas: 2
	template: spec: {
		securityContext: sysctls: [{
			name:  "net.ipv4.ping_group_range"
			value: "0 1000"
		}]
		containers: [{
			image: "cloudflare/cloudflared:\(githubReleases["cloudflare/cloudflared"])"
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
	tunnel:             "9484a4de-29a5-41da-a2e5-5e5562f8d3c4"
	"credentials-file": "/etc/cloudflared/\(tunnel).json"
	"no-autoupdate":    true
	ingress: [{
		service: "http://addem.ingress.svc.cluster.local"
	}]
})

// cloudflared tunnel login
// cloudflared tunnel create qb-ingress # prints tunnel UUID
// TUNNEL=9484a4de-29a5-41da-a2e5-5e5562f8d3c4
// kubectl create secret generic cloudflared-credentials \
//   --dry-run=client \
//   --namespace=ingress \
//   --from-file ~/.cloudflared/$TUNNEL.json \
//   --output yaml | cue cmd import-yaml > cloudflared-secret.enc.cue
// cue cmd seal
// cloudflared tunnel route dns $TUNNEL "*.addem.se"
// cloudflared tunnel route dns $TUNNEL "addem.se"
