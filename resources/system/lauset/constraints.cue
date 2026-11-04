package kube

_namespace: "ory"

_probes: {
	_port: ports[0].name
	ports: [...{name: string}]
	livenessProbe: httpGet: {
		path: "/health/alive"
		port: _port
	}
	readinessProbe: httpGet: {
		path: "/health/ready"
		port: _port
	}
}

#KratosConfigSchema: _
#HydraConfigSchema:  _

_images: {
	kratos:  "oryd/kratos:v26.2.0"
	hydra:   "oryd/hydra:v26.2.0"
	maester: "oryd/hydra-maester:v0.0.42"
}
