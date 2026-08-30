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
