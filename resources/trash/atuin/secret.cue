package kube

k: Secret: "postgres-config": stringData: {
	POSTGRES_DB:       "atuin"
	POSTGRES_USERNAME: "atuin"
	POSTGRES_PASSWORD: "seriously-insecure"
}
