package kube

k: PostgresCluster: "vaultwarden-db": {
	_backup: "0 0 2 * * *"

	spec: {
		instances: 2
		storage: size: "5Gi"
	}
}
