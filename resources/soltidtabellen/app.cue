package kube

k: HTTPRoute: soltidtabellen: spec: {
	hostnames: ["soltidtabellen.se", "www.soltidtabellen.se"]
	parentRefs: [{name: "jdahl", namespace: "ingress"}]
}

k: Service: soltidtabellen: {}

k: Deployment: "soltidtabellen": {
	metadata: labels: "homelab.addem.se/autodeploy": "true"
	spec: {
		template: {
			spec: {
				imagePullSecrets: [{name: "regcred"}]
				containers: [{
					name:            "soltidtabellen"
					image:           "ghcr.io/jonasdahl/soltidtabellen.se:main"
					imagePullPolicy: "Always"
					ports: [{containerPort: 3000, name: "http"}]
				}]
			}
		}
	}
}
