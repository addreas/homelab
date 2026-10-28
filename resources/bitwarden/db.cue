package kube

k: PostgresCluster: "vaultwarden-db": spec: {
	instances: 2
	storage: size: "5Gi"
}
