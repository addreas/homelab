package kube

postgresHost: "logger-db"

k: PostgresCluster: "\(postgresHost)": spec: {
	instances: 2
	storage: size: "1Gi"
	bootstrap: initdb: {
		owner:    "logger"
		database: "logger"
	}
}
