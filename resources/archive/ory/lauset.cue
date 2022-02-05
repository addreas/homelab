package kube

k: Deployment: "lauset": spec: template: spec: containers: [{
	name:  "lauset"
	image: "ghcr.io/addreas/lauset:test"
	envFrom: [{configMapRef: name: "lauset"}]
	env: [{
		name:  "LOG_LEVEL"
		value: "debug"
	}]
	ports: [{
		name:          "http"
		containerPort: 3000
	}]
} & _probes]

k: Service: "lauset": spec: ports: [{
	port:       80
	targetPort: "http"
	name:       "http"
}]

k: ConfigMap: "lauset": data: {
	KRATOS_BROWSER_URL: "https://\(_hostname)/kratos"
	KRATOS_ADMIN_URL:   "http://kratos-admin/"
	KRATOS_PUBLIC_URL:  "http://kratos-public/"
	HYDRA_ADMIN_URL:    "http://hydra-admin/"
}
