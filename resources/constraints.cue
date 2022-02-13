package kube

context: *"nucles" | string

let podTemplate = {
	metadata: annotations: "kubectl.kubernetes.io/default-container": spec.containers[0].name
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

k: ["Deployment" | "StatefulSet" | "DaemonSet"]: [Name=string]: {
	_selector: _ | *{app: Name}
	metadata: labels: _selector
	spec: {
		selector: matchLabels: _selector
		template: podTemplate & {
			metadata: labels: _selector
		}
	}
}

k: Job: [Name=string]: spec: template: podTemplate

k: ["Deployment" | "StatefulSet"]: [string]: spec: replicas: *1 | int

k: StatefulSet: [Name=string]: spec: serviceName: Name

k: Service: [Name=string]: {
	_selector: _ | *close({app: Name})
	metadata: labels: _selector
	spec: {
		selector: _selector
		ports: [...{protocol: *"TCP" | "UDP"}]
	}
}

k: ["ServiceMonitor" | "PodMonitor" | "VMServiceScrape" | "VMPodScrape"]: [Name=string]: {
	_selector: _ | *close({app: Name})
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
				backend: service: _ | *{
					name: "\(Name)"
					port: close({
						number: k.Service[Name].spec.ports[0].port
					})
				}
			}, ...]
		}, ...]
	}
}

k: GrafanaDashboard: [string]: metadata: labels: grafana: "enabled"

k: GitRepository: [string]: spec: interval: _ | *"1h"

k: HelmRepository: [string]: spec: interval: _ | *"1h"

k: HelmRelease: [Name=string]: {
	metadata: namespace: string
	spec: {
		interval: _ | *"1h"
		chart: spec: {
			interval:  _ | *"1h"
			chart:     _ | *Name
			sourceRef: _ | *{
				kind:      "HelmRepository"
				name:      _ | *Name
				namespace: _ | *metadata.namespace
			}
		}
	}
}

k: Kustomization: [Name=string]: spec: {
	interval:  _ | *"1h"
	prune:     _ | *true
	sourceRef: _ | *{
		kind: "GitRepository"
		name: _ | *Name
	}
}
