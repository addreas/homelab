package kube

k: ConfigMap: "hydra-login-consent-node": data: HYDRA_ADMIN_URL: "http://hydra-admin/"

k: Deployment: "hydra-login-consent-node": spec: template: spec: containers: [{
	name:  "hydra-login-consent-node"
	image: "oryd/hydra-login-consent-node:\(_hydraTag)"
	envFrom: [{configMapRef: name: "hydra-login-consent-node"}]
	ports: [{
		name:          "http"
		containerPort: 3000
	}]
}]

k: Service: "hydra-login-consent-node": spec: ports: [{
	port:       80
	targetPort: "http"
	name:       "http"
}]
