package kube

postgresHost: "splitplace-db"

k: PostgresCluster: "\(postgresHost)": spec: {
	instances: 2
	storage: size: "1Gi"
	bootstrap: initdb: {
		owner:    "splitplacewebuser"
		database: "splitplace"
	}
}
