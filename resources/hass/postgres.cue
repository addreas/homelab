package kube

k: PostgresCluster: "hass-recorder": spec: {
	instances: 2
	storage: size: "10Gi"
}
