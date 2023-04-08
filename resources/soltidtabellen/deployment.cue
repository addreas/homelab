package kube

k: Deployment: "soltidtabellen": {
	spec: {
		template: {
			spec: {
				imagePullSecrets: [{name: "regcred"}]
				containers: [{
					name:  "soltidtabellen"
					image: "ghcr.io/jonasdahl/soltidtabellen.se:sha-dcbe383"
					ports: [{containerPort: 3000}]
				}]
			}
		}
	}
}
