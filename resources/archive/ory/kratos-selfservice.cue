package kube

k: Deployment: "kratos-selfservice-ui-node": spec: template: spec: containers: [{
	name:  "kratos-selfservice-ui-node"
	image: "oryd/kratos-selfservice-ui-node:v0.8.0-alpha.3"
	envFrom: [{configMapRef: name: "kratos-selfservice-ui-node"}]
	ports: [{
		name:          "http"
		containerPort: 3000
	}]
	// livenessProbe: httpGet: {
	//  path: "/health/alive"
	//  port: "http"
	// }
	// readinessProbe: httpGet: {
	//  path: "/health/ready"
	//  port: "http"
	// }
}]

k: Service: "kratos-selfservice-ui-node": spec: ports: [{
	port:       80
	targetPort: "http"
	name:       "http"
}]

k: ConfigMap: "kratos-selfservice-ui-node": data: {
	BASE_URL:           "kratos.addem.se"
	KRATOS_ADMIN_URL:   "http://kratos-admin.ory.svc.cluster.local"
	KRATOS_PUBLIC_URL:  "http://kratos-public.ory.svc.cluster.local"
	KRATOS_BROWSER_URL: "https://kratos.addem.se/api"
	JWKS_URL:           "http://oathkeeper-api.ory.svc.cluster.local"
	PROJECT_NAME:       "Nucles"
}

k: Ingress: "kratos": {
	metadata: annotations: {
		"cert-manager.io/cluster-issuer":       "addem-se-letsencrypt"
		"ingress.kubernetes.io/rewrite-target": "/"
	}
	spec: {
		tls: [{
			hosts: ["kratos.addem.se"]
			secretName: "kratos-cert"
		}]
		rules: [{
			host: "kratos.addem.se"
			http: paths: [{
				path:     "/api"
				pathType: "Prefix"
				backend: service: {
					name: "kratos-public"
					port: number: 80
				}
			}, {
				path:     "/"
				pathType: "Prefix"
				backend: service: {
					name: "kratos-selfservice-ui-node"
					port: number: 80
				}
			}]
		}]
	}
}
