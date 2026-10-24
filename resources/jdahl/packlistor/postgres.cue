package kube

postgresHost: "packlistordb"

k: PostgresCluster: "\(postgresHost)": spec: {
	instances: 2
	storage: size: "4Gi"
	bootstrap: initdb: {
		owner:    "packlistor"
		database: "packlistor"
	}
}
