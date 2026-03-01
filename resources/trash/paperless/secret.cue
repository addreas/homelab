package kube

k: Secret: "paperless-secrets": stringData: "PAPERLESS_SECRET_KEY": "adsjahsfi[alsfhi;a;sghil]"

k: Secret: "postgres-config": stringData: {
	POSTGRES_DB:       "paperless"
	POSTGRES_USER:     "paperless"
	POSTGRES_PASSWORD: "seriously-insecure"
}
