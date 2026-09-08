package kube

k: Secret: "atuin/postgres-config": stringData: {
	POSTGRES_DB:       "atuin"
	POSTGRES_USERNAME: "atuin"
	POSTGRES_PASSWORD: "seriously-insecure"
}
