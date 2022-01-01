package kube

k: Service: postgres: {
	spec: ports: [{
		name: "postgres"
		port: 5432
	}]
}
