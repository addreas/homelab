package kube

k: Deployment: "kratos-selfservice-ui-node": spec: template: spec: containers: [{
	name:  "kratos-selfservice-ui-node"
	image: "oryd/kratos-selfservice-ui-node:v0.8.2-alpha.1"
	// image: "oryd/kratos-selfservice-ui-node:\(_kratosTag)"
	envFrom: [{configMapRef: name: "kratos-selfservice-ui-node"}]
	ports: [{
		name:          "http"
		containerPort: 3000
	}]
} & _probes]

k: Service: "kratos-selfservice-ui-node": spec: ports: [{
	port:       80
	targetPort: "http"
	name:       "http"
}]

k: ConfigMap: "kratos-selfservice-ui-node": data: {
	BASE_URL:           _hostname
	KRATOS_BROWSER_URL: "https://\(_hostname)/kratos"
	KRATOS_ADMIN_URL:   "http://kratos-admin/"
	KRATOS_PUBLIC_URL:  "http://kratos-public/"
}
