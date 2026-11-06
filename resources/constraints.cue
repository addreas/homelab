package kube

import "github.com/addreas/homelab/util"

context: "admin@qb"

_secrets: {...}

_namespace: string

if _namespace != _|_ {
	k: [string]: [string]: metadata: namespace: _namespace
	k: Namespace: (_namespace): {}
}

let podTemplate = {
	if len(spec.containers) > 1 {
		metadata: annotations: "kubectl.kubernetes.io/default-container": spec.containers[0].name
	}
	spec: {
		securityContext: {
			fsGroup:             *1000 | int
			fsGroupChangePolicy: *"OnRootMismatch" | "Always"
		}
		containers: [...{
			securityContext: {
				runAsNonRoot:             *true | bool
				runAsUser:                *1000 | int
				runAsGroup:               *1000 | int
				allowPrivilegeEscalation: *false | bool
				capabilities: drop: ["ALL"]
				seccompProfile: type: "RuntimeDefault"
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
	ttlSecondsAfterFinished: _ | *(60 * 60)
	template: podTemplate & {
		spec: restartPolicy: _ | *"OnFailure"
	}
}

k: CronJob: [Name=string]: spec: {
	successfulJobsHistoryLimit: _ | *1
	jobTemplate: spec: {
		template: podTemplate & {
			spec: restartPolicy: _ | *"Never"
		}
	}
}

k: ["Deployment" | "StatefulSet"]: [string]: spec: replicas: *1 | int

k: StatefulSet: [Name=string]: spec: {
	serviceName: _ | *Name

	volumeClaimTemplates: [...{
		spec: accessModes: _ | *["ReadWriteOnce"]
	}]
}

k: ["Deployment" | "StatefulSet" | "DaemonSet" | "Job"]: [Name=string]: spec: template: spec: containers: [{
	name: _ | *Name
}, ...]

k: CronJob: [Name=string]: spec: jobTemplate: spec: template: spec: containers: [{
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

		let workload = k.Deployment[Name] | k.StatefulSet[Name] | k.DaemonSet[Name]

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
	spec: selector: _ | *close({
		matchLabels: _selector
	})
}

k: ServiceMonitor: [Name=string]: spec: {
	if k.Service[Name] != _|_ {
		endpoints: _ | *[{
			port: *k.Service[Name].spec.ports[0].name | k.Service[Name].spec.ports[0].port
		}]
	}
}

k: Ingress: [Name=string]: {
	spec: rules: _ | *[{
		host:             _ | *"\(Name).addem.se"
		ingressClassName: _ | *"cilium"
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

k: HTTPRoute: [Name=string]: {
	_authproxy: true | *false
	_defaultBackendRef: _ | *{
		name: Name
		port: k.Service[Name].spec.ports[0].port
	}
	spec: {
		hostnames: _ | *["\(Name).addem.se"]
		parentRefs: _ | *[{name: "addem", namespace: "ingress"}]
		rules: _ | *[{backendRefs: [_defaultBackendRef]}, ...]
	}

	if _authproxy {
		spec: rules: [{
			matches: [util.#TunnelMatch]
			filters: [util.#AuthProxy]
			backendRefs: [_defaultBackendRef]
		}, {
			backendRefs: [_defaultBackendRef]
		}]
	}
}

k: Probe: [Name=string]: {
	_path: _ | *"/"
	spec: {
		jobName:  _ | *Name
		module:   _ | *"http_2xx"
		interval: _ | *"30s"
		prober: url: _ | *"blackbox-exporter.monitoring.svc:9115"

		if k.HTTPRoute[Name] != _|_ {
			targets: staticConfig: static: _ | *[
				for hostname in k.HTTPRoute[Name].spec.hostnames {"https://\(hostname)\(_path)"},
			]
		}
	}
}

k: SealedSecret: [string]: {
	metadata: _
	spec: template: "metadata": _ | *metadata
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

k: PersistentVolumeClaim: [string]: spec: {
	accessModes: _ | *["ReadWriteOnce"]
}

k: ["PersistentVolume" | "PersistentVolumeClaim" | "CustomResourceDefinition"]: [string]: metadata: labels: {
	"cue.toolkit.fluxcd.io/prune":       "true" | *"false"
	"kustomize.toolkit.fluxcd.io/prune": "true" | *"false"
}

k: OAuth2Client: [name=string]: spec: {
	clientName: _ | *name
	grantTypes: _ | *["client_credentials", "authorization_code", "refresh_token"]
	scopeArray: _ | *["openid", "email", "profile"]
	skipConsent: _ | *true
}
