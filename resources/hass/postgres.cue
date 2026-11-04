package kube

k: PostgresCluster: "hass-recorder": spec: {
	instances: 2
	imageName: "ghcr.io/cloudnative-pg/postgresql:17.6-system-bookworm"
	storage: size: "10Gi"
}
