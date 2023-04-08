package kube

import "encoding/yaml"

k: Deployment: "cloudflared-jonas": spec: {
	replicas: 2
	template: spec: {
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
				configMap: name: "cloudflared-jonas-config"
			}, {
				secret: name: "cloudflared-jonas-credentials"
			}]
		}]
	}
}

k: ConfigMap: "cloudflared-jonas-config": data: "config.yaml": yaml.Marshal({
	tunnel:             "ba5d2522-8430-433b-9779-dc15cc297183"
	"credentials-file": "/etc/cloudflared/ba5d2522-8430-433b-9779-dc15cc297183.json"
	"no-autoupdate":    true
	ingress: [{
		service: "http://haproxy-haproxy-ingress.ingress.svc.cluster.local"
	}]
})

// cloudflared tunnel login
// cloudflared tunnel create nucles-ingress # prints tunnel UUID
// kubectl create secret generic --dry-run=client -o yaml cloudflared-credentials \
//   --from-file ~/.cloudflared/cert.pem \
//   --from-file ~/.cloudflared/ba5d2522-8430-433b-9779-dc15cc297183.json \
//   | cue import-yaml > cloudflared-secret.cue
// cue seal
// rm cloudflared-secret.cue
// cloudflared tunnel route dns ba5d2522-8430-433b-9779-dc15cc297183 "*.addem.se"
// cloudflared tunnel route dns ba5d2522-8430-433b-9779-dc15cc297183 "addem.se"
