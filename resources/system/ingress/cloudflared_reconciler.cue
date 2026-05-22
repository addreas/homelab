@if(cue-controller-dynamic-reconcile)
package kube

reconcile: cloudflared: {
	owner: {
		group: "gateway.networking.k8s.io"
		kind:  "Gateway"

		metadata: annotations: "addem.se/cloudflared":            "true"
		metadata: annotations: "addem.se/cloudflared-tunnel-id"?: string

		metadata: name: _
	}

	watches: routes: {
		group: "gateway.networking.k8s.io"
		kind:  "HTTPRoute"

		spec: _

		select: _ | *false
		for parent in spec.parentRefs
		if parent.name == owner.metadata.name {
			select: true
		}

		selected: [...]
	}

	if owner.metadata.annotations["addem.se/cloudflared-tunnel-id"] == _|_ {
		tasks: {
			tunnelCreate: exec.Run & {
				cmd:     "cloudflared tunnel create --output json --credentials-file credentials.json \(owner.metadata.name)"
				stdout:  string
				_parsed: json.Unmarshal(stdout)
			}

			credentials: file.Read & {
				path:    "credentials.json"
				content: string
			}

			for route in watches.routes.selected
			for hostname in route.spec.hostnames {
				tunnelRoute: (hostname): exec.Run & {
					cmd: "cloudfrared tunnel route dns \(tunnelCreate._parsed.id) \(hostname)"
				}
			}
		}
		owned: secret: data: "credentials.json": base64.Encode(tasks.credentials.content)
	}

	owned: secret: {
		apiVersion: "v1"
		kind:       "Secret"
		metatada: name:           "\(owner.metadata.name)-cloudflared-credentials"
		data: "credentials.json": _
	}

	owned: config: {
		apiVersion: "v1"
		kind:       "ConfigMap"
		metatada: name: "\(owner.metadata.name)-cloudflared-config"
		data: "config.yaml": yaml.Marshal({
			tunnel:             _tunnelId
			"credentials-file": "/etc/cloudflared/credentials.json"
			"no-autoupdate":    true
			ingress: [{
				service: "http://\(owner.metadata.name).\(owner.metadata.namespace).svc.cluster.local"
			}]
		})
	}

	owned: deployment: {
		apiVersion: "apps/v1"
		kind:       "Deployment"
		metadata: name: "\(owner.metadata.name)-cloudflared"
		spec: {
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
						configMap: name: "\(owner.metadata.name)-cloudflared-config"
					}, {
						secret: name: "\(owner.metadata.name)-cloudflared-credentials"
					}]
				}]
			}
		}
	}
}
