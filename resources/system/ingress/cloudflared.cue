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
	tunnel:             "d8e11b22-80ad-42ef-9c8b-92992118e669"
	"credentials-file": "/etc/cloudflared/\(tunnel).json"
	"no-autoupdate":    true
	ingress: [{
		service: "http://haproxy-haproxy-ingress.ingress.svc.cluster.local"
	}]
})

// cloudflared tunnel login
// cloudflared tunnel create nucles-ingress # prints tunnel UUID
// TUNNEL=d8e11b22-80ad-42ef-9c8b-92992118e669
// kubectl create secret generic cloudflared-credentials \
//   --dry-run=client \
//   --namespace=ingress \
//   --from-file ~/.cloudflared/$TUNNEL.json \
//   --output yaml | cue import-yaml > cloudflared-secret.cue
// cue seal
// rm cloudflared-secret.cue
// cloudflared tunnel route dns $TUNNEL "*.addem.se"
// cloudflared tunnel route dns $TUNNEL "addem.se"
