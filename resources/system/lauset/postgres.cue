package kube

k: PostgresCluster: "lauset-db": spec: {
	instances: 2
	storage: size: "1Gi"
}

k: PostgresDatabase: "lauset-db-kratos": spec: {
	name:  "kratos"
	owner: "app"
	cluster: name: "lauset-db"
}

k: PostgresDatabase: "lauset-db-hydra": spec: {
	name:  "hydra"
	owner: "app"
	cluster: name: "lauset-db"
}
