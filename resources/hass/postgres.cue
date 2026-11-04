package kube

k: PostgresCluster: "hass-recorder": spec: {
	instances: 2
	imageName: "ghcr.io/cloudnative-pg/postgresql:18.1-standard-trixie"
	storage: size: "10Gi"
	bootstrap: initdb: {
		database: "hass"
		owner:    "hass"
	}
}
