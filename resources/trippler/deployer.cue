package kube

k: Ingress: "deployproto": {}

k: Service: deployproto: {}

k: Deployment: "deployproto": spec: template: spec: containers: [{
	ports: [{containerPort: 8080, name: "http"}]
	image: "ghcr.io/jonasdahl/pod-killer:main"
	env: [
		{name: "KEY", value:            "VALUE"},
		{name: "NAMESPACE", value:      "trippler"},
		{name: "LABEL_SELECTOR", value: "app=prototype"},
	]
}]
