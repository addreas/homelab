package kube

context: *"nucles" | string

k: ["Deployment" | "StatefulSet" | "DaemonSet"]: [Name=string]: {
	_selector: _ | *{app: Name}
	metadata: labels: _selector
	spec: {
		selector: matchLabels: _selector
		template: {
			metadata: {
				labels: _selector
				annotations: "kubectl.kubernetes.io/default-container": spec.containers[0].name
			}
			spec: {
				securityContext: fsGroup: *1000 | int
				containers: [...{
					securityContext: {
						allowPrivilegeEscalation: *false | bool
						runAsUser:                *1000 | int
						runAsGroup:               *1000 | int
					}
					ports: [...{protocol: *"TCP" | "UDP"}]
				}]
			}
		}
	}
}

k: ["Deployment" | "StatefulSet"]: [string]: spec: replicas: *1 | int

k: StatefulSet: [Name=string]: spec: serviceName: Name

k: Service: [Name=string]: {
	_selector: _ | *{app: Name}
	metadata: labels: _selector
	spec: {
		selector: _selector
		ports: [...{protocol: *"TCP" | "UDP"}]
	}
}

k: ServiceMonitor: [Name=string]: {
	_selector: _ | *{app: Name}
	metadata: labels: _selector
	spec: selector: matchLabels: _selector
}

k: Ingress: [Name=string]: {
	metadata: annotations: _ | *{"cert-manager.io/cluster-issuer": "addem-se-letsencrypt"}
	spec: {
		tls: _ | *[{
			hosts: ["\(Name).addem.se", ...]
			secretName: "\(Name)-cert"
		}, ...]
		rules: _ | *[{
			host: _ | *"\(Name).addem.se"
			http: paths: _ | *[{
				path:     _ | *"/"
				pathType: _ | *"Prefix"
				backend: service: {
					name: _ | *"\(Name)"
					port: number: _ | *k.Service[Name].spec.ports[0].port
				}
			}, ...]
		}, ...]
	}
}

k: GrafanaDashboard: [string]: {
	metadata: labels: grafana: "enabled"
	spec: {
		json:    *"" | string
		jsonnet: *"" | string
	}
}
