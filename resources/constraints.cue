package kube

context: *"nucles" | string

_homelab: {
	kind:      "GitRepository"
	name:      "homelab"
	namespace: "flux-system"
}

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

k: Job: [string]: spec: {
	ttlSecondsAfterFinished: 60 * 60
	template:                podTemplate & {
		spec: restartPolicy: _ | *"OnFailure"
	}
}

k: ["Deployment" | "StatefulSet"]: [string]: spec: replicas: *1 | int

k: StatefulSet: [Name=string]: spec: serviceName: _ | *Name

k: ["Deployment" | "StatefulSet" | "DaemonSet" | "Job"]: [Name=string]: spec: template: spec: containers: [{
	name: _ | *Name
}, ...]

k: ["Deployment" | "StatefulSet" | "DaemonSet" | "Job"]: [string]: spec: template: spec: {
	// only allow explicit "Always", otherwise use tags and/or sha
	initContainers: [...{
		imagePullPolicy: _ | *"IfNotPresent"
	}]
	containers: [...{
		imagePullPolicy: _ | *"IfNotPresent"
	}]
}

k: Service: [Name=string]: {
	_selector: _ | *close({app: Name})
	metadata: labels: _selector
	spec: {
		selector: _selector
		ports: [...{protocol: *"TCP" | "UDP"}]

		let workload = k.Deployment[Name] | k.StatefulSet[Name]

		if workload != _|_ {
			ports: _ | *[
				for container in workload.spec.template.spec.containers for port in container.ports {
					if port.name != _|_ {
						name: port.name
					}
					"port":   port.containerPort
					protocol: port.protocol
				},
			]
		}
	}
}

k: ["ServiceMonitor" | "PodMonitor" | "VMServiceScrape" | "VMPodScrape"]: [Name=string]: {
	_selector: _ | *close({app: Name})
	metadata: labels: _selector
	spec: selector:   _ | *close({
		matchLabels: _selector
	})
}

k: Ingress: [Name=string]: {
	// redundant since we use cloudflare as a fronting proxy
	// metadata: annotations: _ | *{"cert-manager.io/cluster-issuer": "addem-se-letsencrypt"}

	_authproxy: true | *false
	if _authproxy {
		metadata: annotations: {
			"ingress.kubernetes.io/auth-url":    "https://authproxy.addem.se/oauth2/auth"
			"ingress.kubernetes.io/auth-signin": "https://authproxy.addem.se/oauth2/start?rd=https://%[hdr(host)]%[path]"
		}
	}
	spec: {
		// redundant since we use cloudflare as a fronting proxy
		// tls: _ | *[{
		//  hosts: ["\(Name).addem.se", ...]
		//  secretName: "\(Name)-cert"
		// }, ...]
		rules: _ | *[{
			host: _ | *"\(Name).addem.se"
			http: paths: _ | *[{
				path:     _ | *"/"
				pathType: _ | *"Prefix"
				backend: service: _ | *{
					name: "\(Name)"
					port: *close({
						number: k.Service[Name].spec.ports[0].port
					}) | close({
						name: k.Service[Name].spec.ports[0].name
					})
				}
			}, ...]
		}, ...]
	}
}

k: SealedSecret: [string]: {
	metadata: _
	spec: template: "metadata": _ | *metadata
}

k: GrafanaDashboard: [string]: spec: instanceSelector: _ | *close({
	matchExpressions: [{
		key: "global-ignore"
		operator: "DoesNotExist"
	}]
})

k: GrafanaDatasource: [string]: spec: instanceSelector: _ | *close({
	matchExpressions: [{
		key: "global-ignore"
		operator: "DoesNotExist"
	}]
})

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

k: RoleBinding: [Name=string]: {
	roleRef: {
		apiGroup: "rbac.authorization.k8s.io"
		kind:     _ | *"Role"
		name:     _ | *Name
	}
	subjects: _ | *[{
		kind: _ | *"ServiceAccount"
		name: _ | *Name
	}]
}
