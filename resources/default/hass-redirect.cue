package kube

k: Ingress: oldhass: {}

k: Service: oldhass: {
	spec: {
		type:         "ExternalName"
		externalName: "hass.localdomain"
		ports: [{
			name: "http"
			port: 8123
		}]
	}
}
