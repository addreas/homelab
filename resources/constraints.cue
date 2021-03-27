package kube

context: *"nucles" | string

k: StatefulSet: [Name=string]: spec: serviceName: Name

k: ["Deployment" | "StatefulSet"]: [Name=string]: {
	_selector: _ | *{app: Name}
	metadata: labels: _selector
	spec: {
		replicas: *1 | int
		selector: matchLabels: _selector
		template: {
			metadata: labels: _selector
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
	metadata: annotations: "cert-manager.io/cluster-issuer": "addem-se-letsencrypt"
	spec: {
		tls: [{
			hosts:      _ | *["\(Name).addem.se"]
			secretName: _ | *"\(Name)-cert"
		}]
		rules: [{
			host: _ | *"\(Name).addem.se"
			http: paths: [{
				path:     _ | *"/"
				pathType: _ | *"Prefix"
				backend: service: {
					name: _ | *"\(Name)"
					port: number: _ | *k.Service[Name].spec.ports[0].port
				}
			}, ...]
		}]
	}
}

k: GrafanaDashboard: [string]: {
	metadata: labels: grafana: "enabled"
	spec: {
		json:    *"" | string
		jsonnet: *"" | string
	}
}
