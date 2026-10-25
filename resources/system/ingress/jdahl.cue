package kube

import "encoding/yaml"

let tunnelID = "ba5d2522-8430-433b-9779-dc15cc297183"

k: Gateway: jdahl: spec: {
	gatewayClassName: "cilium"
	listeners: [{
		name:     "http"
		port:     80
		protocol: "HTTP"
		allowedRoutes: namespaces: from: "All"
	}]
}

k: Deployment: "cloudflared-jdahl": spec: {
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
				configMap: name: "cloudflared-jdahl-config"
			}, {
				secret: name: "cloudflared-jdahl-credentials"
			}]
		}]
	}
}

k: ConfigMap: "cloudflared-jdahl-config": data: "config.yaml": yaml.Marshal({
	tunnel:             tunnelID
	"credentials-file": "/etc/cloudflared/\(tunnelID).json"
	"no-autoupdate":    true
	ingress: [{
		service: "http://cilium-gateway-jdahl.ingress.svc.cluster.local"
	}]
})
