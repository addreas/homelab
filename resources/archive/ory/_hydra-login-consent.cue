package kube

k: Deployment: "hydra-login-consent-node": spec: template: spec: containers: [{
	name:  "hydra-login-consent-node"
	image: "oryd/hydra-login-consent-node:\(_hydraTag)"
	envFrom: [{configMapRef: name: "hydra-login-consent-node"}]
	ports: [{
		name:          "http"
		containerPort: 3000
	}]
	livenessProbe: httpGet: {
	 path: "/health/alive"
	 port: "http"
	}
	readinessProbe: httpGet: {
	 path: "/health/ready"
	 port: "http"
	}
}]

k: Service: "hydra-login-consent-node": spec: ports: [{
	port:       80
	targetPort: "http"
	name:       "http"
}]

k: ConfigMap: "hydra-login-consent-node": data: {
	BASE_URL:           "hydra.addem.se"
	hydra_ADMIN_URL:   "http://hydra-admin.ory.svc.cluster.local"
	hydra_PUBLIC_URL:  "http://hydra-public.ory.svc.cluster.local"
	hydra_BROWSER_URL: "https://hydra.addem.se/api"
	JWKS_URL:           "http://oathkeeper-api.ory.svc.cluster.local"
	PROJECT_NAME:       "Nucles"
}

k: Ingress: "hydra": {
	metadata: annotations: {
		"cert-manager.io/cluster-issuer":       "addem-se-letsencrypt"
		"ingress.kubernetes.io/rewrite-target": "/"
	}
	spec: {
		tls: [{
			hosts: ["hydra.addem.se"]
			secretName: "hydra-cert"
		}]
		rules: [{
			host: "hydra.addem.se"
			http: paths: [{
				path:     "/api"
				pathType: "Prefix"
				backend: service: {
					name: "hydra-public"
					port: number: 80
				}
			}, {
				path:     "/"
				pathType: "Prefix"
				backend: service: {
					name: "hydra-login-consent-node"
					port: number: 80
				}
			}]
		}]
	}
}
