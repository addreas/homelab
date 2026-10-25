package kube

import "encoding/yaml"

let tunnelID = "9484a4de-29a5-41da-a2e5-5e5562f8d3c4"

k: Gateway: addem: {
	metadata: annotations: "cert-manager.io/cluster-issuer": "addem-se-letsencrypt"
	spec: {
		gatewayClassName: "cilium"
		infrastructure: labels: advertise: "arp"
		listeners: [{
			name:     "http"
			port:     80
			protocol: "HTTP"
			allowedRoutes: namespaces: from: "All"
		}, {
			name:     "https"
			hostname: "*.addem.se"
			port:     443
			protocol: "HTTPS"
			allowedRoutes: namespaces: from: "All"
			tls: {
				mode: "Terminate"
				certificateRefs: [{name: "addem-se-tls"}]
			}
		}]
	}
}

k: Deployment: cloudflared: spec: {
	replicas: 2
	template: spec: {
		securityContext: sysctls: [{
			name:  "net.ipv4.ping_group_range"
			value: "0 1000"
		}]
		containers: [{
			image: _images.cloudflared
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
	tunnel:             tunnelID
	"credentials-file": "/etc/cloudflared/\(tunnelID).json"
	"no-autoupdate":    true
	ingress: [{
		service: "http://cilium-gateway-addem.ingress.svc.cluster.local"
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
